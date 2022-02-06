import SwiftUI

struct ComplexModificationsAssetsView: View {
  @Binding var showing: Bool
  @ObservedObject private var assetFiles = ComplexModificationsAssetFiles.shared

  var body: some View {
    VStack(alignment: .leading, spacing: 12.0) {
      Text("files \(assetFiles.files.count)")
      List {
        ForEach($assetFiles.files) { $assetFile in
          VStack(alignment: .leading, spacing: 8.0) {
            HStack(alignment: .center, spacing: 0) {
              Text(assetFile.title)
                .font(.title)

              Button(action: {
                Settings.shared.addComplexModificationRules(assetFile)
                showing = false
              }) {
                Label("Enable All", systemImage: "plus.circle.fill")
                  .font(.caption)
              }

              Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
              ForEach($assetFile.assetRules) { $assetRule in
                HStack(alignment: .center, spacing: 0) {
                  Text(assetRule.description)

                  Button(action: {
                    Settings.shared.addComplexModificationRule(assetRule)
                    showing = false
                  }) {
                    Label("Enable", systemImage: "plus.circle.fill")
                  }
                }
              }
            }
            .padding(.leading, 32.0)
            .padding(.vertical, 16.0)

            Divider()
          }
        }
      }
      .background(Color(NSColor.textBackgroundColor))

      Spacer()

      Button(action: {
        showing = false
      }) {
        Label("Close", systemImage: "xmark")
          .frame(minWidth: 0, maxWidth: .infinity)
      }
      .padding(.top, 36.0)
    }
    .padding()
    .frame(width: 1000, height: 600)
    .onAppear {
      assetFiles.updateFiles()
    }
  }
}

struct ComplexModificationsAssetsView_Previews: PreviewProvider {
  @State static var showing = true

  static var previews: some View {
    ComplexModificationsAssetsView(showing: $showing)
  }
}
