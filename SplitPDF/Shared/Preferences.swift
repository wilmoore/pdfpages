import Foundation

/// App preferences for PDF splitting behavior
enum OutputFormat: String, CaseIterable, Identifiable {
    case pdf = "PDF"
    case png = "PNG"

    var id: String { rawValue }

    var fileExtension: String {
        switch self {
        case .pdf: return "pdf"
        case .png: return "png"
        }
    }
}

/// Shared preferences using UserDefaults
class Preferences {
    static let shared = Preferences()

    private let outputFormatKey = "outputFormat"

    private init() {}

    var outputFormat: OutputFormat {
        get {
            guard let rawValue = UserDefaults.standard.string(forKey: outputFormatKey),
                  let format = OutputFormat(rawValue: rawValue) else {
                return .pdf
            }
            return format
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: outputFormatKey)
        }
    }
}
