import SwiftUI

struct DDGAnnotaion: View {
    var location: DDGLocation
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                MapBalloon()
                    .frame(width: 100, height: 70)
                    .foregroundColor(.brandPrimary)
                
                Image(uiImage: location.createSquare())
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.top, 4)
                
                Text("99")
                    .font(.system(size: 11, weight: .bold))
                    .frame(width: 26, height: 18)
                    .background(Color.grubRed)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .offset(x: 20)
            }
            
            Text(location.name)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}

struct DDGAnnotaion_Previews: PreviewProvider {
    static var previews: some View {
        DDGAnnotaion(location: DDGLocation(record: MockData.location))
    }
}
