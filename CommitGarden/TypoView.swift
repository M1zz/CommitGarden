//
//  TypoView.swift
//  CommitGarden
//
//  Created by hyunho lee on 6/22/23.
//

import SwiftUI

struct TypoView: View {
    @State var yOffset : CGFloat = 6
    @State var xOffset : CGFloat = 30
    @State var xScale : CGFloat = -1
    
    var body: some View {
        GeometryReader{ geometry in
            Image("grass_01")
                .resizable()
                //.background(.blue)
                .scaledToFit()
                .frame(height: 17)
                .position(x: xOffset+(geometry.size.width)/2,
                          y:yOffset+1.5) //180
                .scaleEffect(
                    x:xScale,
                    anchor: UnitPoint(
                        x: (xOffset/geometry.size.width) + 0.5,
                        y: 0.5)) //전체 위치중 중간값
                .onAppear {
                    let totalTime : CGFloat = 2
                    let totalStep : CGFloat = 15
                    let tmPrStp = totalTime/totalStep

                }
            Image("grass_02")
                .resizable()
                //.background(.green)
                .scaledToFit()
                .frame(height: 17)
                .position(x: xOffset+(geometry.size.width)/2 + 10,
                          y:yOffset+1.5) //180
                .scaleEffect(
                    x:xScale,
                    anchor: UnitPoint(
                        x: (xOffset/geometry.size.width) + 0.5,
                        y: 0.5)) //전체 위치중 중간값
                .onAppear {
                    let totalTime : CGFloat = 2
                    let totalStep : CGFloat = 15
                    let tmPrStp = totalTime/totalStep

                }
        }.ignoresSafeArea()
    }
}


struct TypoView_Previews: PreviewProvider {
    static var previews: some View {
        TypoView()
            .previewDevice("iPhone 14 Pro")
            .previewDisplayName("iPhone 14 Pro")
        
        TypoView()
            .previewDevice("iPhone 14 Pro Max")
            .previewDisplayName("iPhone 14 Pro Max")
    }
}


struct GrassView: View {
    
    @State var yOffset : CGFloat = 6
    @State var xOffset : CGFloat = 30
    @State var xScale : CGFloat = -1
    
    var body: some View  {
        GeometryReader{ geometry in
            Image("grass2")
                .resizable()
                .scaledToFit()
                .frame(height: 17)
                .position(x: xOffset+(geometry.size.width)/2,y:yOffset+0.5) //180
                .scaleEffect(
                    x:xScale,
                    anchor: UnitPoint(
                        x: (xOffset/geometry.size.width) + 0.5,
                        y: 0.5)) //전체 위치중 중간값
                .onAppear {
                    let totalTime : CGFloat = 2
                    let totalStep : CGFloat = 15
                    let tmPrStp = totalTime/totalStep
                    
                }
        }
    }
}
