// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

enum ScreenError {
    case unmanageable
    case offline
    case canRetry
}

struct ErrorView: View {
    let error: ScreenError
    let action: () async -> Void

    var body: some View {
        VStack {
            Text("errorView.genericErrorTitle")
                .textStyle(.header)

            Spacer().frame(height: Constant.extraSpacing)

            switch error {
            case .unmanageable:
                Text("errorView.unmanageableErrorMessage")
            case .offline:
                Text("errorView.offlineErrorMessage")
            case .canRetry:
                Text("errorView.accountLimitErrorMessage")
            }

            Spacer().frame(height: Constant.extraSpacing)

            Button("errorView.retryButtonTitle") {
                Task {
                    await action()
                }
            }
        }
        .padding(Constant.padding)
        .background(Color.errorBGColor)
        .cornerRadius(Constant.cornerRadius)
        .padding(.horizontal, Constant.horizontalPadding)
    }
}

private enum Constant {
    static let cornerRadius: CGFloat = 10
    static let extraSpacing: CGFloat = 10
    static let padding: CGFloat = 20
    static let horizontalPadding: CGFloat = 60
}

#Preview("Unmanageable") {
    ErrorView(error: .unmanageable, action: {})
}

#Preview("Offline") {
    ErrorView(error: .offline, action: {})
}

#Preview("CanRetry") {
    ErrorView(error: .canRetry, action: {})
}

