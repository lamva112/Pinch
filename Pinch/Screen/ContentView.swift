//
//  ContentView.swift
//  Pinch
//
//  Created by bui khac lam on 28/01/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK : - PROPERTY
    
    @State private var isAnimating : Bool = false
    @State private var iamgeScale : CGFloat = 1
    @State private var iamgeOffset : CGSize = .zero
    @State private var isDrawerOpen : Bool = false
    
    let pages: [Page] = pagesData
    @State private var pageIndex: Int = 1
    
    // MARK : - FUCTION
    func resetIamgeState(){
        return withAnimation(.spring()){
            iamgeScale = 1
            iamgeOffset = .zero
        }
    }
    
    func currentPage() -> String {
        return pages[pageIndex - 1].iamgeName
    }
    // MARK : - CONTENT
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.clear
                // MARK: PAGE IMAGE
                Image(currentPage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2),radius: 12,x: 2,y: 2)
                    .opacity(isAnimating ? 1:0)
                    .offset(x:iamgeOffset.width,y: iamgeOffset.height)
                    .scaleEffect(iamgeScale)
                // MARK: -1. TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if iamgeScale == 1{
                            withAnimation(.spring()){
                                iamgeScale = 5
                            }
                        }else{
                        resetIamgeState()
                            
                        }
                    })
                // MARK: -2. DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                withAnimation(.linear(duration: 1)){
                                    iamgeOffset = value.translation
                                }
                            }
                            .onEnded{ _ in
                                if iamgeScale <= 1 {
                                    resetIamgeState()
                                }
                                
                            }
                    )
                // MARK: -3. MANIFICATION
                    .gesture(
                        MagnificationGesture()
                            .onChanged {value in
                                withAnimation(.linear(duration: 1)){
                                    if iamgeScale >= 1 && iamgeScale <= 5 {
                                        iamgeScale = value
                                    }else if iamgeScale > 5 {
                                        iamgeScale = 5
                                    }
                                }
                            }.onEnded{ _ in
                                if iamgeScale > 5 {
                                    iamgeScale = 5
                                }else if iamgeScale <= 1 {
                                    resetIamgeState()
                                }
                                
                            }
                    )
                    
            }//ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            })
            // MARK: - INFOR PANNEL
            .overlay(
                inforPanelView(sacle: iamgeScale, offet: iamgeOffset).padding(.horizontal).padding(.top,30),
                alignment: .top
            )
            // MARK: - CONTROLS
            .overlay(
                Group{
                    HStack{
                        // SCALE DOWN
                        Button(
                            action: {
                                if iamgeScale > 1 {
                                    iamgeScale -= 1
                                }
                                
                                if iamgeScale <= 1 {
                                    resetIamgeState()
                                }
                            },
                            label: {
                                ControlImageView(icon: "minus.magnifyingglass")
                            }
                        )
                        // RESET
                        Button(
                            action: {
                                resetIamgeState()
                            },
                            label: {
                                ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                            }
                        )
                        // SACLE
                        Button(
                            action: {
                                withAnimation(.spring()){
                                    if iamgeScale < 5 {
                                        iamgeScale += 1
                                    }
                                    
                                    if iamgeScale > 5 {
                                        iamgeScale = 5
                                    }
                                }
                            },
                            label: {
                                ControlImageView(icon: "plus.magnifyingglass")
                            }
                        )
                        
                    } //: CONTROLS
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    
                }.padding(.bottom,30),
                alignment: .bottom
            )
            // MARK: - DRAWER
            .overlay(
                HStack(spacing: 12){
                    // MARK: - DRAWER HANDLE
                    Image(systemName: isDrawerOpen ?"chevron.compact.right":"chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height:40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut){
                                isDrawerOpen.toggle()
                            }
                        })
                    //MARK: - THUMBNAILS
                    
                    ForEach(pages) { item in
                        Image(item.thumnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5),value: isDrawerOpen)
                            .onTapGesture(perform: {
                                isAnimating = true
                                pageIndex = item.id
                            })
                    }
                    Spacer()
                } //: DRAWER
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1:0)
                    .frame(width:260)
                    .padding(.top,UIScreen.main.bounds.height / 12)
                    .offset(x:isDrawerOpen ? 20 : 215),
                alignment:.topTrailing
            )
        }//NAVIGATION
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
