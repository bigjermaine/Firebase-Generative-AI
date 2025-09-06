//
//  AIViewModel.swift
//  TestApp
//
//  Created by Daniel Jermaine on 06/09/2025.
//

import Foundation
import FirebaseAI


@Observable
class AIViewModel {
    var isGenerating = false
    var notes: String = ""
    var responseData: String = ""
    var errorMessage: String? = nil  

    private var model: GenerativeModel = {
        let generationConfig = GenerationConfig(
            temperature: 0.9,
            maxOutputTokens: 200
        )
        let ai = FirebaseAI.firebaseAI(backend: .googleAI())
        return ai.generativeModel(
            modelName: "gemini-2.5-flash"
        )
    }()

    func generatePlaylist() async {
        guard !notes.isEmpty else {
            responseData = "Please enter a mood or theme."
            return
        }
        isGenerating = true
        errorMessage = nil
        responseData = "" // Clear old results
        defer { isGenerating = false }

        let prompt = """
        Create a playlist of 10 songs based on this description: \(notes).
        Return in the format:
        1. Song - Artist
        2. Song - Artist
        """

        do {
            let response = try await model.generateContent(prompt)
            responseData = response.text ?? "No songs generated."
        } catch {
            errorMessage = error.localizedDescription
            responseData = "❌ Error: \(error.localizedDescription)"
        }
    }
}
