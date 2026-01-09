import SwiftUI

struct PreferencesView: View {
    @State private var selectedFormat: OutputFormat = Preferences.shared.outputFormat

    var body: some View {
        Form {
            Section {
                Picker("Output Format", selection: $selectedFormat) {
                    ForEach(OutputFormat.allCases) { format in
                        Text(format.rawValue).tag(format)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedFormat) { newValue in
                    Preferences.shared.outputFormat = newValue
                }

                Text(formatDescription)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } header: {
                Text("Output Settings")
            }
        }
        .formStyle(.grouped)
        .frame(width: 320, height: 120)
    }

    private var formatDescription: String {
        switch selectedFormat {
        case .pdf:
            return "Each page will be saved as a separate PDF file."
        case .png:
            return "Each page will be exported as a PNG image."
        }
    }
}

#Preview {
    PreferencesView()
}
