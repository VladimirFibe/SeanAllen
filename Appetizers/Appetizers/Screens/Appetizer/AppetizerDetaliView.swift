import SwiftUI

struct AppetizerDetaliView: View {
    @EnvironmentObject var order: Order
    let appetizer: Appetizer
    @Binding var isShowingDetail: Bool
    var body: some View {
        let action: () -> () = { isShowingDetail = false }
        VStack {
            AppetizerRemoteImage(urlString: appetizer.imageURL)
                .aspectRatio(contentMode: .fit)
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
            
            BrandButton(title: "$\(appetizer.price, specifier: "%.2f") - Add to Order") {
                order.add(appetizer)
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
                .environmentObject(Order())
        }
    }
}
