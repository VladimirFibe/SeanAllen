import SwiftUI

struct AppetizerDetaliView: View {
    let appetizer: Appetizer
    @Binding var isShowingDetail: Bool
    var body: some View {
        let action: () -> () = { isShowingDetail = false }
        VStack {
            AppetizerRemoteImage(urlString: appetizer.imageURL)
                .scaledToFit()
                .frame(width: 300, height: 225)
            
            VStack {
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(appetizer.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding(.horizontal)
                
                HStack(spacing: 40) {
                    NutritionInfo(title: "Calories", value: "\(appetizer.calories)")
                    NutritionInfo(title: "Carbs", value: "\(appetizer.carbs) g")
                    NutritionInfo(title: "Protein", value: "\(appetizer.protein) g")
                }
            }
            
            Spacer()
            
            BrandButton(title: String(format: "$%.2f - Add to Order", appetizer.price)) {
                isShowingDetail = false
            }
            .padding(.bottom, 30)
        }
        .frame(width: 300, height: 525)
        .background(Color.systemBackground)
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(XDismissButton(action: action).padding(), alignment: .topTrailing)
    }
}

struct AppetizerDetaliView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            AppetizerDetaliView(appetizer: MockData.sampleAppetizer, isShowingDetail: .constant(true))
        }
    }
}
