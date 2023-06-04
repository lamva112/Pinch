//
//  inforPanelView.swift
//  Pinch
//
//  Created by bui khac lam on 12/03/2023.
//

import SwiftUI

struct inforPanelView: View {
    var sacle: CGFloat
    var offet: CGSize
    
    @State private var isInfoPanelVisible : Bool = false
    
    var body: some View {
        HStack{
            // MARK: - HOTSPOT
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30,height: 30)
                .onLongPressGesture(minimumDuration: 0.0) {
                    withAnimation(.easeOut){
                        isInfoPanelVisible.toggle()
                    }
                }
            Spacer()
            // MARK: - INFO PANEL
            HStack(spacing : 2){
                Image(systemName: "arrow.down.right.and.arrow.up.left")
                Text("\(sacle)")

                Spacer()

                Image(systemName: "arrow.left.and.right")
                Text("\(offet.width)")

                Spacer()

                Image(systemName: "arrow.up.and.down")
                Text("\(offet.height)")

                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
        }
    }
    
    struct inforPanelView_Previews: PreviewProvider {
        static var previews: some View {
            inforPanelView(sacle: 1, offet: .zero)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
