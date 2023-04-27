//
//  WebView+Representable.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 27.04.23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let webUrl: URL

    func makeUIView(
        context: Context
    ) ->  WKWebView {
        return WKWebView()
    }

    func updateUIView(
        _ uiView: WKWebView,
        context: Context
    ) {
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: webUrl))
    }
}
