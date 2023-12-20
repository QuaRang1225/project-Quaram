import SwiftUI
import Foundation

struct AnalogClock:View{
    
//    
//    @Binding var analogClock  : Bool
//    
//    init(analogClock:Binding<Bool> = .constant(false)){
//        _analogClock = analogClock
//    }
    
    var body: some View{
        ZStack(alignment: .topLeading){
            ClockWindow()
        }.background{
            Image("NIGHT")
                .resizable()
                .ignoresSafeArea()
        }.navigationBarBackButtonHidden(true)
        
        
    }
}
struct AnalogClock_Previews: PreviewProvider {
    static var previews: some View {
        AnalogClock()
    }
}
