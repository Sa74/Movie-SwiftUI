//
//  WebView+Representable.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 27.04.23.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {

    private let videoUrl: URL
    private let networkHandler: NetworkProtocol
    private let webView = WKWebView()

    @State private var htmlString: String?

    init(
        videoUrl: URL,
        networkHandler: NetworkProtocol = NetworkHandler()
    ) {
        self.videoUrl = videoUrl
        self.networkHandler = networkHandler
    }

    func makeUIView(
        context: Context
    ) ->  WKWebView {
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(
        _ uiView: WKWebView,
        context: Context
    ) {
        Task {
            if htmlString == nil,
                let htmlString = try? await networkHandler.fetchHTMLString(from: videoUrl) {
                DispatchQueue.main.async {
                    uiView.loadHTMLString(
                        htmlString,
                        baseURL: videoUrl
                    )
                    self.htmlString = htmlString
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func playVideo() {
        webView.evaluateJavaScript(
            "document.querySelector('video').play();",
            completionHandler: nil
        )
    }

    class Coordinator: NSObject, WKNavigationDelegate {

        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation!
        ) {
            let js = """
            (function() {
                function simulateTap() {
                    console.log("Simulating tap.");
                    var tapEvent = new MouseEvent("click", {
                                    bubbles: true,
                                    cancelable: true,
                                    view: window,
                                    clientX: \(webView.bounds.midX),
                                    clientY: \(webView.bounds.midY)
                                });
                                var videoElement = document.getElementsByTagName("video")[0];
                                videoElement.dispatchEvent(tapEvent);
                    }
                    simulateTap();
            })();
            """
            webView.evaluateJavaScript(js)
        }
    }
}
