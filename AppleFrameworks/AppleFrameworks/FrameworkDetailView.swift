import SwiftUI

struct FrameworkDetailView: View {
    let framework: Framework
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color(.label))
                    .imageScale(.large)
                    .frame(width: 44, height: 44)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            Spacer()
            FrameworkTitleView(framework: framework)
            Text(framework.description)
                .font(.body)
            Spacer()
            Button {
                
            } label: {
                AFButton(title: "Learn More")
            }

        }
        .padding(.horizontal)
    }
}

struct FrameworkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkDetailView(framework: MockData.sampleFramework)
            .preferredColorScheme(.dark)
    }
}
