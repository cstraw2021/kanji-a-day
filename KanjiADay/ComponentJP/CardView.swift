import SwiftUI
import Foundation

struct CardJP : View {
    var kanji : Kanji
    var reader : GeometryProxy
    @Binding var swiped : Int
    @Binding var show : Bool
    @Binding var selected : Kanji
    var name : Namespace.ID
    
    var body: some View{
        Spacer(minLength: 0)
        ZStack(alignment:Alignment(horizontal: .trailing, vertical: .bottom),content:{
            VStack{
                Button(action: {
                    withAnimation(.spring()){
                        selected = kanji
                        show.toggle()
                    }
                }){
                    Text("\(kanji.character)")
                        .font(.system(size: 140,weight: .bold))
                        .foregroundColor(.black)
                        .matchedGeometryEffect(id: kanji.character, in: name)
                }

                
                Text("\(kanji.meaning)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.top, 0) // Add padding to match card padding
                
                HStack{
                    VStack(alignment: .leading, spacing: 12){
                        Text("On: \(kanji.onyomi)")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .offset(x: -10) // Adjust offset to match card padding
                        Text("Kun: \(kanji.kunyomi)")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .offset(x: -10) // Adjust offset to match card padding
                    }
                    Spacer(minLength: 0)
                }
                .padding(.horizontal,20)
                .padding(.bottom,20)
                .padding(.top,25)
            }
        })
        .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: UIScreen.main.bounds.height - 100)
        .background(Color.white)
        .cornerRadius(25)
        .padding(.horizontal, 30 + (CGFloat(kanji.order - swiped) * 10))
        .offset(y: kanji.order - swiped <= 2 ? CGFloat(kanji.order - swiped) * 25 : 50)
        .shadow(radius: 5)
        .contentShape(Rectangle())
        Spacer(minLength: 0)
    }
}
