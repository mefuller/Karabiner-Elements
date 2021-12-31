import SwiftUI

struct LogView: View {
    @ObservedObject var logMessages = LogMessages.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            GeometryReader { _ in
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(logMessages.entries) { e in
                            Text(e.text)
                                .font(.custom("Menlo", size: 11.0))
                                .foregroundColor(e.foregroundColor)
                                .background(e.backgroundColor)
                        }
                        Spacer()
                    }
                    .background(Color(NSColor.textBackgroundColor))
                }
            }
            HStack {
                Text("Current time: \(logMessages.currentTimeString)")
                
                Spacer()

                Button(action: {
                    var text = ""
                    for e in logMessages.entries {
                        text += e.text + "\n"
                    }

                    let pboard = NSPasteboard.general
                    pboard.clearContents()
                    pboard.writeObjects([text as NSString])
                }) {
                    Label("Copy to pasteboard", systemImage: "arrow.right.doc.on.clipboard")
                }
            }
        }
        .padding()
        .onAppear {
            logMessages.watch()
        }
        .onDisappear {
            logMessages.unwatch()
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
