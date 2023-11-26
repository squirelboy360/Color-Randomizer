//
//  ContentView.swift
//  IosColorTesting --Randomizer
//
//  Created by Tahiru Agbanwa on 26/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var counter:Int = 0;
    @State private var showWarning:Bool = false;
    
    func giveHapticFeedback(isLight:Bool? = nil, isMedium:Bool? = nil, isError:Bool? = nil){
        let style:UIImpactFeedbackGenerator.FeedbackStyle
        
        if(isLight ?? false){
            style = .light
        }else if(isMedium ?? false){
            style = .medium
        }else if(isError ?? false){
            style = .heavy
        }else{
            style = .medium
        }
        
        let generator = UIImpactFeedbackGenerator(style:style)
        generator.prepare()
        generator.impactOccurred()
    }
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("The counter Value is \(counter)")
            
            VStack {
                Text("Increase counter till Color of box changes and border gets circular till the point it stops").bold()
                Text("Its harder than you think").bold()
                HStack {
                    Text("Red: \(CGFloat(Double(counter)*0.001))").padding()
                    Text("Green: \(CGFloat(Double(counter)*0.002))").padding()
                    Text("Blue: \(CGFloat(Double(counter)*0.003))").padding()
                    Text("Opacity: 1")
                }
                HStack(content: {
                    Button("Increase (+1)"){
                            counter+=1
                        //haptic feedback
                        giveHapticFeedback(isLight: true)
                        
                    }.foregroundColor(.white)
                        .padding()
                    Button("Decrease (-1)"){
                        if(counter<1){
                            showWarning = true;
                            giveHapticFeedback(isError: true)
                        }else{
                            counter-=1
                            giveHapticFeedback(isLight: true)
                        }
                    }.foregroundColor(.white)
                        .padding()
                }).padding().background(Color(uiColor: UIColor(red: CGFloat(Double(counter)*0.001), green: CGFloat(Double(counter)*0.002), blue: CGFloat(Double(counter)*0.003), alpha: 1.0))).cornerRadius(CGFloat(counter))
                //CGFloat converts
                //! Change red aspect of backgound
                
            }
        }
        .alert(isPresented: $showWarning, content: {
            Alert(title: Text("Warning"),
            message: Text("Counter can't be less than 0"),
                  dismissButton: .default(Text("Okay")))
        })
        
    }
}
#Preview {
    ContentView()
}
