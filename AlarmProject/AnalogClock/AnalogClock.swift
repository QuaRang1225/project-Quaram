import SwiftUI
import Foundation

struct AnalogClock:View{
    

    let width  = UIScreen.main.bounds.width
    var timer = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    @State var currentTime = Time(hour: 0, minute: 0, second: 0)
    @State var currentDate = Date()
    
    var body: some View{
        VStack{
            Spacer()
                HStack{
                    Spacer()
                    ZStack{
                       Circle()
                            .foregroundColor(.clear)
                            .frame(width: width - 100,height: width - 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white,lineWidth: 5).padding(-5)).padding()
                        ForEach(0..<60, id: \.self){ i in
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 2,height: (i % 5) == 0 ? 12 : 5)
                                .offset(y: (width - 110)/2)
                                .rotationEffect(.init(degrees: Double(i * 6)))
                            if i%5 == 0{
                                Text("\(i == 0 ? 12 : i/5)").offset(y:10).rotationEffect(.init(degrees: -Double(i * 6)))
                                    .offset(y: -(width - 110)/2 - 30)
                                    .rotationEffect(.init(degrees: Double(i * 6)))
                                    .padding(.bottom)
                            }
                           
                        }
                        hand(width: 2, height: 180, time: 6, timeMode: currentTime.second)
                        hand(width: 4, height: 200, time: 6, timeMode: currentTime.minute)
                        hand(width: 4.5, height: 240, time: 30,timeMode: currentTime.hour)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 15,height: 15)
                        
                    }
                    
                    Spacer()
                    
                }
               
                .onAppear{
                    setCurrentTime()
                }
                .onReceive(timer){ _ in
                   setCurrentTime()
                }
            
            Text(FormatterClass.shared.dateFormatter.string(from: currentDate) + " (\(FormatterClass.shared.weekdayStringFromInt())) " + FormatterClass.shared.meridiemFormatter.string(from: currentDate))
                .padding(.top,40)
            Text(FormatterClass.shared.timeFormatter.string(from: currentDate))
                .font(.largeTitle)
               
                
            Spacer()
        }
        .onReceive(timer) { input in
            self.currentDate = input
        }
        .foregroundColor(.white)
        .bold()
        .navigationBarBackButtonHidden()
        .background(Image("NIGHT"))
        
        
    }
    private func hand(width:CGFloat,height:CGFloat,time:Int,timeMode:Int) -> some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: width,height: (self.width - height)/2)
            .offset(y: -(self.width - height)/4)
            .rotationEffect(.init(degrees: Double(timeMode * time)))
    }
    private func setCurrentTime(){
        let calender = Calendar.current
        
        let hour = calender.component(.hour, from: currentDate)
        let min = calender.component(.minute, from: currentDate)
        let sec = calender.component(.second, from: currentDate)
        
        withAnimation(Animation.linear(duration: 0.01)){
            self.currentTime = Time(hour: hour, minute: min, second: sec)
        }
    }

}
struct AnalogClock_Previews: PreviewProvider {
    static var previews: some View {
        AnalogClock()
    }
}
