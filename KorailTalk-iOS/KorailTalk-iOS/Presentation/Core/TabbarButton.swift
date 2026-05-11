//
//  TabbarButton.swift
//  KorailTalk-iOS
//
//  Created by 장지인 on 5/11/26.
//

import UIKit

final class TabbarButton: UIButton{
    
    // MARK: - Properties
    
    private let normalImaage: UIImage?
    private let selectedImage: UIImage?
    private let buttonTitle: String
    
    // MARK: - Initializer
    
    init(
        normalImage: UIImage?,
        selectedImage: UIImage?,
        title: String
    ){
        self.normalImaage = normalImage
        self.selectedImage = selectedImage
        self.buttonTitle = title
        
        super.init(frame: .zero)
        
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setStyle(){
        var config = UIButton.Configuration.plain()
        
        config.image = normalImaage?.withRenderingMode(.alwaysOriginal)
        config.imagePlacement = .top
        config.imagePadding = 0
        config.titleLineBreakMode = .byClipping
        
        tintColor = .clear
        configuration = config
        configurationUpdateHandler = { button in
            var titleContainer = AttributeContainer()
            titleContainer.font = .pretendard(.caption1)
            titleContainer.foregroundColor = .black
            
            var config = button.configuration
            
            if button.isSelected{
                config?.image = self.selectedImage?.withRenderingMode(.alwaysOriginal)
            }
            
            else{
                config?.image = self.normalImaage?.withRenderingMode(.alwaysOriginal)
            }
            
            config?.attributedTitle = AttributedString(
                self.buttonTitle,
                attributes: titleContainer
            )
            
            button.configuration = config
        }
    }
}
