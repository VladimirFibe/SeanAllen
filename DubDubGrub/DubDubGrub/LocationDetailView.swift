import SwiftUI

struct LocationDetailView: View {
    @ObservedObject var viewModel: LocationDetailViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                bannerImage
                VStack(alignment: .center, spacing: 16) {
                    addressLabel
                    descriptionView
                    buttons
                    Text("Who's Here?").font(.title2.bold())
                    ZStack {
                        if viewModel.checkedInProfiles.isEmpty {
                            Text("Nobody's Here 😔").font(.title2.bold())
                                .foregroundColor(.secondary)
                                .padding(.top, 30)
                        } else {
                            friends
                        }
                        if viewModel.isLoading {
                            LoadingView()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Spacer()
            }
            if viewModel.selectedFriend != nil {
                Color(.systemBackground)
                    .ignoresSafeArea()
                    .opacity(0.9)
                    .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.4)))
                    .zIndex(1)
                PersonDetailView(profile: $viewModel.selectedFriend)
                    .transition(.opacity.combined(with: .slide))
                    .animation(.easeOut, value: viewModel.selectedFriend)
                    .zIndex(2)
            }
        }
        .onAppear {
            viewModel.getCheckedInProfiles()
            viewModel.getCheckedInStatus()
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    Text("Dismiss")
                }
                
            }
        }
    }
    var bannerImage: some View {
        Image(uiImage: viewModel.location.createBanner())
            .resizable()
            .scaledToFill()
            .frame(height: 100)
    }
    var addressLabel: some View {
        Label(viewModel.location.address, systemImage: "mappin.and.ellipse")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.caption)
            .foregroundColor(.secondary)
    }
    var descriptionView: some View {
        Text(viewModel.location.description)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
    }
    var buttons: some View {
        HStack(spacing: 20) {
            CircleColorButton(color: .brandPrimary, image: "location.fill", size: 22) {
                viewModel.getDirectionsToLocation()
            }
            Link(destination: URL(string: viewModel.location.websiteURL)!) {
                CircleColorLabel(color: .brandPrimary, image: "network", size: 22)
            }
            CircleColorButton(color: .brandPrimary, image: "phone.fill", size: 22) {
                viewModel.callLocation()
            }
            if let _ = CloudKitManager.shared.profileRecordID {
                CircleColorButton(color: viewModel.isCheckedIn ? .grubRed : .brandPrimary, image: viewModel.isCheckedIn ? "person.fill.xmark" : "person.fill.checkmark", size: 22) {
                    viewModel.updateCheckInStatus(to: viewModel.checking)
                }
            }
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            Capsule()
                .fill(Color(.secondarySystemBackground))
        )
    }
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    var friends: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.checkedInProfiles) { profile in
                    VStack {
                        AvatarView(image: profile.avatar.convertToUIImage(in: .square), width: 80)
                        Text(profile.fistName)
                    }
                    .onTapGesture {
                        withAnimation {
                            viewModel.selectedFriend = profile
                        }
                    }
                }
            }
        }
    }
}
