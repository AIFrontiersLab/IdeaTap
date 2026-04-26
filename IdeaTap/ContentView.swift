import SwiftUI
import UIKit

struct ContentView: View {
    @State private var pastedURL: URL?
    @State private var manualURLText: String = ""
    @State private var statusMessage: String?
    @State private var isSaving: Bool = false

    @Environment(\.scenePhase) private var scenePhase

    private var brandBlue: Color {
        Color(red: 10/255, green: 102/255, blue: 194/255)
    }

    private let categories: [CategoryItem] = [
        .init(title: "Innovation", sheetTab: "Innovation", icon: "lightbulb"),
        .init(title: "Agentic", sheetTab: "Agentic", icon: "bolt.badge.a"),
        .init(title: "AI", sheetTab: "AI", icon: "sparkles"),
        .init(title: "Inspiration", sheetTab: "Inspiration", icon: "quote.opening")
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Clipboard Link")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(brandBlue)

            Text("Copy a link. That’s it.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            urlInputBox

            categoryGrid

            if let statusMessage = statusMessage {
                Text(statusMessage)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(brandBlue.opacity(0.9))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
            }

            Spacer()
        }
        .padding(.top, 18)
        .onAppear(perform: loadClipboardURL)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                loadClipboardURL()
            }
        }
    }

    private var urlInputBox: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Paste URL here (or auto-filled from clipboard)", text: $manualURLText)
                .textInputAutocapitalization(.never)
                .keyboardType(.URL)
                .autocorrectionDisabled()
                .font(.footnote)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)

            HStack {
                Button {
                    loadClipboardURL()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.clockwise")
                        Text("Paste from Clipboard")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(isSaving)

                Spacer()

                if let url = pastedURL {
                    Text(url.host ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 24)
    }

    private var categoryGrid: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                categoryButton(item: categories[0]) // Innovation
                categoryButton(item: categories[1]) // Agentic
            }
            HStack(spacing: 12) {
                categoryButton(item: categories[2]) // AI
                categoryButton(item: categories[3]) // Inspiration
            }
        }
        .padding(.horizontal, 24)
    }

    private func categoryButton(item: CategoryItem) -> some View {
        let isInnovation = item.sheetTab == "Innovation"
        let isDisabled = isSaving || (isInnovation ? !hasValidManualURL : (pastedURL == nil))

        return Button {
            if isInnovation {
                saveManualToInnovations()
            } else {
                saveClipboardToSheet(sheetTab: item.sheetTab, displayTitle: item.title)
            }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: item.icon)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 28, height: 28)
                    .background(Color.black.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Spacer()

                if isSaving {
                    ProgressView()
                        .scaleEffect(0.9)
                }
            }
            .foregroundColor(.primary)
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(14)
            .opacity(isDisabled ? 0.55 : 1.0)
        }
        .disabled(isDisabled)
    }

    private var hasValidManualURL: Bool {
        let text = manualURLText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: text),
              let scheme = url.scheme?.lowercased(),
              scheme == "http" || scheme == "https" else {
            return false
        }
        return true
    }

    private func saveClipboardToSheet(sheetTab: String, displayTitle: String) {
        guard let url = pastedURL else {
            statusMessage = "No valid clipboard URL found."
            return
        }

        isSaving = true
        statusMessage = "Saving to \(displayTitle)..."

        LinkSheetService.shared.sendLink(url: url, category: sheetTab) { result in
            DispatchQueue.main.async {
                isSaving = false
                switch result {
                case .success(let serverMessage):
                    statusMessage = serverMessage ?? "Saved to \(displayTitle) tab."
                case .failure(let error):
                    statusMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }

    private func saveManualToInnovations() {
        let text = manualURLText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let url = URL(string: text),
              let scheme = url.scheme?.lowercased(),
              scheme == "http" || scheme == "https" else {
            statusMessage = "Please paste a valid URL for Innovations."
            return
        }

        isSaving = true
        statusMessage = "Saving to Innovation..."

        LinkSheetService.shared.sendLink(url: url, category: "Innovation") { result in
            DispatchQueue.main.async {
                isSaving = false
                switch result {
                case .success(let serverMessage):
                    statusMessage = serverMessage ?? "Saved to Innovations tab."
                    manualURLText = ""
                case .failure(let error):
                    statusMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }

    private func loadClipboardURL() {
        let text = (UIPasteboard.general.string ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let url = URL(string: text),
              let scheme = url.scheme?.lowercased(),
              scheme == "http" || scheme == "https" else {
            pastedURL = nil
            return
        }

        pastedURL = url
        manualURLText = url.absoluteString
    }
}

private struct CategoryItem {
    let title: String
    let sheetTab: String
    let icon: String
}
