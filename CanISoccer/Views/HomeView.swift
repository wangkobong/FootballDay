//
//  HomeView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    
    // MARK: - UI Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private let searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .red
        return stackView
    }()
    
    private let locationButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let searchTextfield: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private let searchButton: UIButton = {
        let searchButton = UIButton()
        
        return searchButton
    }()
    
    private let datePickerTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .green
        return textField
    }()
    
    private let temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .darkGray
        return stackView
    }()
    
    private let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Clouds"
        label.backgroundColor = .blue
        return label
    }()
    
    private let weatherIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "체감온도는 33°C, 강수확률은 0% 입니다."
        return label
    }()
    
    private let recommendationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "공을 차기엔 기온이 높습니다. \n다음에 플레이 하시는게 어떨까요?🤣"
        return label
    }()
    
    
    // MARK: - Configures
 
    override func configureUI() {
        self.backgroundColor = .yellow
        [containerView, searchStackView, datePickerTextField, temperatureStackView, weatherStatusLabel, weatherIconImage, weatherDescriptionLabel, recommendationLabel].forEach { addSubview($0) }
        
        [locationButton, searchTextfield, searchButton].forEach { addSubview($0) }
        
      
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchStackView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(16)
            $0.trailing.equalTo(self.snp.trailing).offset(-16)
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        datePickerTextField.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(16)
            $0.trailing.equalTo(self.snp.trailing).offset(-16)
            $0.top.equalTo(searchStackView.snp.bottom).offset(10)
            $0.height.equalTo(40)
        }
        
        temperatureStackView.snp.makeConstraints {
            $0.top.equalTo(datePickerTextField.snp.bottom).offset(8)
            $0.leading.equalTo(self.snp.leading).offset(16)
            $0.height.equalTo(100)
            $0.width.equalTo(110)
        }
        
        weatherStatusLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureStackView)
            $0.leading.equalTo(temperatureStackView.snp.trailing).offset(8)
            $0.height.equalTo(temperatureStackView)
        }
        
        weatherIconImage.snp.makeConstraints {
            $0.top.equalTo(temperatureStackView)
            $0.leading.equalTo(weatherStatusLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(self.snp.trailing).offset(-16)
            $0.height.equalTo(temperatureStackView)
        }
        
        weatherDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureStackView.snp.bottom).offset(16)
            $0.leading.equalTo(self.snp.leading).offset(16)
            $0.trailing.equalTo(self.snp.trailing).offset(-16)
            $0.height.equalTo(30)
        }
        
        recommendationLabel.snp.makeConstraints {
            $0.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(16)
            $0.trailing.equalTo(self.snp.trailing).offset(-16)
            $0.height.equalTo(90)
        }
        
    }
}
