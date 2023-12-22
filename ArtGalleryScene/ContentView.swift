//
//  ContentView.swift
//  ArtGalleryScene
//
//  Created by Saba Gogrichiani on 22.12.23.
//

import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var opacity: Double = 1.0
    @State private var hue: Double = 0.0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Pinch to Zoom
                Text("Pinch to Zoom")
                    .font(.headline)
                Image("bag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            scale = value.magnitude
                        }
                    )
                    .scaleEffect(scale)
                resetButtonStyle {
                    scale = 1.0
                }

                // MARK: - Rotate
                Text("Rotate")
                    .font(.headline)
                Image("chair")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .gesture(RotationGesture()
                        .onChanged { value in
                            rotation = value
                        }
                    )
                    .rotationEffect(rotation)
                resetButtonStyle {
                    rotation = .zero
                }

                // MARK: - Drag
                Text("Drag")
                    .font(.headline)
                Image("dadaSink")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .offset(offset)
                    .gesture(DragGesture()
                        .onChanged { value in
                            offset = CGSize(width: lastOffset.width + value.translation.width,
                                            height: lastOffset.height + value.translation.height)
                        }
                        .onEnded { value in
                            lastOffset = offset
                        }
                    )
                resetButtonStyle {
                    offset = .zero
                    lastOffset = .zero
                }

                // MARK: - Double Tap to Change Opacity
                Text("Double Tap to Change Opacity")
                    .font(.headline)
                Image("daido")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .gesture(TapGesture(count: 2)
                        .onEnded {
                            opacity = self.opacity == 1.0 ? 0.5 : 1.0
                        }
                    )
                    .opacity(opacity)
                resetButtonStyle {
                    opacity = 1.0
                }

                // MARK: - Long Press to Change Hue
                Text("Long Press to Change Hue")
                    .font(.headline)
                Image("wanderer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .gesture(LongPressGesture(minimumDuration: 2)
                        .onEnded { _ in
                            hue = hue == 0.0 ? 0.5 : 0.0
                        }
                    )
                    .hueRotation(Angle(degrees: hue * 360))
                resetButtonStyle {
                    hue = 0.0
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }

    private func resetButtonStyle(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text("Reset")
                .padding(8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    ContentView()
}
