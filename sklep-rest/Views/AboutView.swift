import SwiftUI
import MapKit

struct AboutView: View {
    
    @EnvironmentObject var shopRepo: ShopRepo
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 50.048968,
            longitude: 19.931817
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    
    
    
    var body: some View {

        VStack(spacing: 40) {
                Text("Szmatex sp. z.o.o.")
                    .font(.title)
                    .fontWeight(.semibold)
            
                Map(coordinateRegion: $region, annotationItems: shopRepo.getAll()) {shop in
                    MapMarker(coordinate: CLLocationCoordinate2D(
                        latitude: shop.latitude,
                        longitude: shop.longtitude
                    ))
                }
                    .frame(maxHeight: 400)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a"
                )
                .frame(maxWidth: .infinity ,alignment: .leading)
                .padding(.leading)

    
            }
            .frame(maxHeight: .infinity, alignment: .leading)
            
            
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
