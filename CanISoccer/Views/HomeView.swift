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
        return view
    }()
    
    private let searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    private (set) var locationButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        return button
    }()
    
    private let searchTextfield: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "주소를 입력해주세요"
        return textField
    }()
    
    private (set) var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return button
    }()
    
    private let datePickerTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "시간대를 선택해주세요"
        return textField
    }()
    
    private let temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        stackView.spacing = 0
        return stackView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(50)
        label.text = "26"
        return label
    }()
    
    private let degreeLabel: UILabel = {
       let label = UILabel()
        label.text = "°"
        label.textAlignment = .center
        label.font = label.font.withSize(60)
        return label
    }()
    
    private let celsius: UILabel = {
       let label = UILabel()
        label.text = "C"
        label.textAlignment = .center
        label.font = label.font.withSize(40)
        return label
    }()
    
    private let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Clouds"
        label.font = label.font.withSize(25)
        label.textAlignment = .right
        return label
    }()
    
    private let weatherIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.bolt")
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
        self.backgroundColor = .systemBackground
        [containerView, searchStackView, datePickerTextField, temperatureStackView, weatherStatusLabel, weatherIconImage, weatherDescriptionLabel, recommendationLabel].forEach { addSubview($0) }
        
        [locationButton, searchTextfield, searchButton].forEach { searchStackView.addSubview($0) }
        
        [temperatureLabel, degreeLabel, celsius].forEach { temperatureStackView.addSubview($0) }
        
      
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchStackView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(16)
            $0.trailing.equalTo(self.snp.trailing).offset(-16)
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        locationButton.snp.makeConstraints {
            $0.top.equalTo(searchStackView.snp.top)
            $0.leading.equalTo(searchStackView.snp.leading)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        searchTextfield.snp.makeConstraints {
            $0.top.equalTo(searchStackView.snp.top)
            $0.leading.equalTo(locationButton.snp.trailing)
            $0.trailing.equalTo(searchButton.snp.leading)
            $0.height.equalTo(searchStackView)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(searchStackView.snp.top)
            $0.trailing.equalTo(searchStackView.snp.trailing)
            $0.width.equalTo(40)
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
            $0.width.equalTo(119)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureStackView.snp.top)
            $0.leading.equalTo(temperatureStackView.snp.leading)
            $0.height.equalTo(temperatureStackView)
            $0.width.equalTo(61.5)
        }
        
        degreeLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureStackView.snp.top)
            $0.leading.equalTo(temperatureLabel.snp.trailing)
            $0.height.equalTo(temperatureStackView)
            $0.width.equalTo(24.5)
        }
        
        celsius.snp.makeConstraints {
            $0.top.equalTo(temperatureStackView.snp.top)
            $0.leading.equalTo(degreeLabel.snp.trailing)
            $0.trailing.equalTo(temperatureStackView.snp.trailing)
            $0.height.equalTo(temperatureStackView)
            $0.width.equalTo(33)
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
            $0.width.equalTo(100)
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
