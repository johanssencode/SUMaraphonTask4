//
//  ContentView.swift
//  SUMaraphonTask4
//
//  Created by A.J. on 10.12.2024.
//


/* ТЗ Задание 4
 Когда нажимаем на кнопку из задания «Следующий Трек», она уменьшается и появляется круглый фон.
 
 - Всё сделать в ButtonStyle. Кнопке только установить стиль.
 - Скейл 0.86. Длина анимации нажатия 0.22 секунды.
 - ⚠️ Анимация непрерываемая. Кнопка должна дойти до скейла и только после вернуться.
 
 Чтобы убедится что задание выполнено правильно, поставьте скейл 0. Если кнопка пропадает и появится - значит анимация прошла до конца ✅. Если кнопка не пропала - значит анимация прервалась, когда вы отпустили кнопку ❌
 */

import SwiftUI

struct ForwardButtonStyle: ButtonStyle { // Всё сделать в ButtonStyle.
    
    @State private var isAnimating = false
    
    var scale = 0.86 // Скейл 0.86 , для теста поставим в 0.0
    var animationLength = 0.22 // Длина анимации нажатия 0.22 секунды.
    var circleZoom = 1.6 // размер круга
    var circleOpacity = 0.1 // прозрачность круга]
    var circleColor = Color(.lightGray)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        
            .scaleEffect(isAnimating ? scale : 1.0)  // скейл кнопки
            .background(Circle().fill(circleColor.opacity(circleOpacity)).scaleEffect(isAnimating ? circleZoom : 0)) // Фон, Скейл Круга
            .onChange(of: configuration.isPressed) { _, newValue in
                
                // newValue, true - кнопка нажата, false - кнопка отпущена
                
                // Если кнопка нажата и анимация не происходит, анимируем
                if newValue && !isAnimating {
                    
                    withAnimation(.easeInOut(duration: animationLength)) {
                        
                        isAnimating = true // Стартуем анимацию
                        
                    } completion: {
                        
                        withAnimation(.easeInOut) { isAnimating = false }
                        
                    }
                }
            }//.onChange
    }
    
}

//MARK:  Кнопка из предыдущего задания
/// Взял кнопку по Вашему варианту из предыдущего задания тк она намного проще реализована, чем в моем варианте. В данную кнопку просто прописал созданный мной стиль .buttonStyle(ForwardButtonStyle())
struct PlayForwardButton: View {
    
    @State private var performAnimation: Bool = false
    var buttonColor = Color(.black) // цвет кнопки
    
    var body: some View {
        
        Button {
            if !performAnimation {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
            GeometryReader { proxy in
                
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .foregroundColor(buttonColor)
            }
        }//: Button
        .buttonStyle(ForwardButtonStyle()) // Кнопке только установить стиль.
        .frame(maxWidth: 62)
        
    }
    
}



#Preview {
    
    PlayForwardButton()
    
}

