//
//  ContentView.swift
//  AudoPlayAudioSound
//
//  Created by Kagen Zhao on 2020/10/2.
//

import SwiftUI
import LaunchAtLogin
import Combine

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Toggle("开启", isOn: configuration.$isOn).labelsHidden()
        }.padding()
    }
}

struct ContentView: View {
    @State var isOpen: Bool = SoundManager.shared.isOpen
    @ObservedObject private var launchAtLogin = LaunchAtLogin.observable
    var body: some View {
        VStack(spacing: 0) {
            Toggle("开启", isOn: $isOpen)
                .toggleStyle(CustomToggleStyle())
                .frame(maxWidth: .infinity, maxHeight: 30)
                .onReceive([isOpen].publisher.first(), perform: { value in
                    guard value != SoundManager.shared.isOpen else { return }
                    if value {
                        SoundManager.shared.begin()
                    } else {
                        SoundManager.shared.end()
                    }
                })
            Toggle("开机自启动", isOn: $launchAtLogin.isEnabled)
                .toggleStyle(CustomToggleStyle())
                .frame(maxWidth: .infinity, maxHeight: 30)
            
            Button("关闭") {
                exit(0)
            }.padding()
        }
    }
}
