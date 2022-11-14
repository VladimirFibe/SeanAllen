//
//  SpotDetailView.swift
//  DubDubGrub
//
//  Created by Vladimir Fibe on 13.11.2022.
//

import SwiftUI

struct SpotDetailView: View {
    let spot: Spot
    var body: some View {
        VStack {
            Image("default-banner-asset")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
            VStack(alignment: .center, spacing: 16) {
                Label("1 S Market St Ste 40", systemImage: "mappin.and.ellipse")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text("It's \(spot.name). Enough said. 2022-11-14 20:35:12.020029+0600 DubDubGrub[1889:37111] [VKDefault] Missing MeshRenderables for ground mesh layer for (2/2) of ground tiles. Tile debug info: (Key: 2644.6357.14.255 t:34 kt:0, Has mesh errors: 0, MeshInstance count: 2, PendingMaterial count: 2, Invisible MeshInstances count: 0 | Key: 2644.6358.14.255 t:34 kt:0, Has mesh errors: 0, MeshInstance count: 2, PendingMaterial count: 2, Invisible MeshInstances count: 0)")
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                buttons
                Text("Who's Here?")
                    .font(.title2.bold())
                friends
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            Spacer()
        }
        .navigationTitle(spot.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    
                } label: {
                    Text("Dismiss")
                }

            }
        }
    }
    var buttons: some View {
        HStack(spacing: 20) {
            CircleColorButton(color: .brandPrimary, image: "location.fill", size: 22)
            Link(destination: URL(string: "https://www.apple.com")!) {
                CircleColorLabel(color: .brandPrimary, image: "network", size: 22)
            }
            CircleColorButton(color: .brandPrimary, image: "phone.fill", size: 22)
            CircleColorButton(color: .red, image: "person.fill.xmark", size: 22)
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
                ForEach(0 ..< 15) { item in
                    VStack {
                        AvatarView(image: "default-avatar", width: 80)
                        Text("Name")
                    }
                }
            }
        }
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpotDetailView(spot: Spot.all[0])
        }
    }
}

