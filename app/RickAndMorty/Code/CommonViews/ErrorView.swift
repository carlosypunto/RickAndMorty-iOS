// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    let error: ScreenError
    let retry: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            switch error {
            case .unmanageable:
                VStack {
                    Text("errorView.unmanageableErrorTitle")
                        .font(.title2)
                        .fontWeight(.bold)

                    Spacer().frame(height: Constant.extraSpacing)

                    Text("errorView.unmanageableErrorMessage")

                    Spacer().frame(height: Constant.extraSpacing)

                    Button("errorView.okButtonTitle") {
                        dismiss()
                    }
                }
            case .offline, .canRetry:
                VStack {
                    Text("errorView.genericErrorTitle")
                        .font(.title2)

                        .fontWeight(.bold)

                    Spacer().frame(height: Constant.extraSpacing)

                    if case .offline = error {
                        Text("errorView.offlineErrorMessage")
                    } else {
                        Text("errorView.accountLimitErrorMessage")
                    }

                    Spacer().frame(height: Constant.extraSpacing)

                    Button("errorView.retryButtonTitle") {
                        dismiss()
                        retry()
                    }
                }
            }
        }
        .padding(Constant.padding)
        .background(Constant.errorBGColor)
        .cornerRadius(Constant.cornerRadius)
        .padding(.horizontal, Constant.horizontalPadding)
    }
}

private enum Constant {
    static let errorBGColor: Color = Color("AlertBG")
    static let cornerRadius: CGFloat = 10
    static let extraSpacing: CGFloat = 10
    static let padding: CGFloat = 20
    static let horizontalPadding: CGFloat = 60
}

#Preview("Unmanageable") {
    ErrorView(error: .unmanageable, retry: {})
}

#Preview("Offline") {
    ErrorView(error: .offline, retry: {})
}

#Preview("CanRetry") {
    ErrorView(error: .canRetry, retry: {})
}

