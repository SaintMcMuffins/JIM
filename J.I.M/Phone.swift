//
//  Phone.swift
//  J.I.M
//
//  Created by Julian Manaois on 12/06/22.
//


import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class PhoneView: UIViewController {

	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var labelSubTitle: UILabel!
	@IBOutlet var textFieldCountry: UITextField!
	@IBOutlet var textFieldPhoneNumber: UITextField!

	var countries: [[String: String]] = []

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()

		navigationItem.titleView = UIImageView(image: UIImage(systemName: "circles.hexagongrid.fill"))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Continue", style: .done, target: self, action: #selector(actionContinue))

		loadData()
	}

	// MARK: - Data methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {

		countries.removeAll()

		if let url = Bundle.main.url(forResource: "phone_countyCode", withExtension: "json") {
			do {
				let data = try Data(contentsOf: url)
				let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
				if let dictionary = object as? [[String: String]] {
					countries = dictionary
				}
			} catch {
			}
		}

		labelTitle.text = "Start with\nphone number"
		labelSubTitle.text = "Enter your mobile number. A text message will be sent to verify your account."
		textFieldCountry.text = "+1"
		textFieldPhoneNumber.text = "123 456 7890"
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionContinue() {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCountries(_ sender: Any) {

		showPickerView(title: "Select country")
	}

	// MARK: - Picker methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func showPickerView(title: String) {

		let alertView = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)

		let height:NSLayoutConstraint = NSLayoutConstraint(item: alertView.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
		alertView.view.addConstraint(height)

		let pickerview = UIPickerView(frame: CGRect(x: 0, y: 35, width: alertView.view.frame.size.width - 16, height: 200))
		pickerview.delegate = self
		pickerview.dataSource = self

		alertView.view.addSubview(pickerview)

		alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
			self.textFieldCountry.text = self.countries[pickerview.selectedRow(inComponent: 0)]["dial_code"]
		}))
		present(alertView, animated: true, completion: nil)
	}
}

// MARK: - UIPickerViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension PhoneView: UIPickerViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

		let country = countries[row]
		return "\(country["name"] ?? "") (\(country["dial_code"] ?? ""))"
	}
}

// MARK: - UIPickerViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension PhoneView: UIPickerViewDataSource {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfComponents(in pickerView: UIPickerView) -> Int {

		return 1
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

		return countries.count
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {

		return 30.0
	}
}