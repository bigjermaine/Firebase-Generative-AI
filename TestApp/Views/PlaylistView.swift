//
//  PlaylistView.swift
//  TestApp
//
//  Created by Daniel Jermaine on 06/09/2025.
//


import SwiftUI


struct PlaylistView: View {
    @State var viewModel = AIViewModel()
    @Namespace private var animation

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.purple.opacity(0.9), Color.black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 30) {
                    // Title
                    Text("🎶 AI Playlist Generator")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                        .shadow(radius: 10)
                    
                    // Input
                    TextField("Type a mood or theme (e.g. workout, chill)", text: $viewModel.notes)
                        .padding()
                        .background(.white.opacity(0.15))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal)
                    
                    // Button / Progress
                    if viewModel.isGenerating {
                        ProgressView("Generating playlist...")
                            .tint(.white)
                            .foregroundColor(.white)
                            .matchedGeometryEffect(id: "button", in: animation)
                    } else {
                        Button(action: {
                            Task {
                                await viewModel.generatePlaylist()
                            }
                        }) {
                            Text("Generate Playlist")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .shadow(color: .purple.opacity(0.7), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal)
                        .matchedGeometryEffect(id: "button", in: animation)
                    }
                    
                    // Playlist output
                    ScrollView {
                        if !viewModel.responseData.isEmpty {
                            Text(viewModel.responseData)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white.opacity(0.1))
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .animation(.easeInOut(duration: 0.5), value: viewModel.responseData)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    PlaylistView()
}
