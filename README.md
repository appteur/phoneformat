# Swift Phone Number Formatter

## Overview
This project was written to simplify phone number formatting in Swift 4+. There are faster and simple ways to implement a phone number formatter, however, this repo is designed to be highly configurable and support multiple languages and formatting styles. (multiple language support is still in development, assistance is welcome!) 

A sample project is included in the pod to demonstrate use.

## Usage

This pod breaks responsibilities into separate components for more configurability.

To make use of built in formatting functionality you simply have to instantiate a formatter with a defined ruleset.

```Swift

var formatter = PhoneFormatter(rulesets: PNFormatRuleset.usParethesis())

```

This library has two (more are in progress) predefined rule sets included. You can create your own rule sets to support any formatting behavior you need. 

NOTE: If you would like to contribute more rule sets, fork the repo, add your rule sets and create a pull request with your changes. The rule sets should be separated into folders by locale following the example of the rule sets already built in, with a file containing an extension of PNFormatRulest, with static factory functions descriptively named.

Here are some rule sets currently included:

```Swift

// This extension defines rulesets for phone numbers within the United States
public extension PNFormatRuleset {

    // Formats phone numbers:
    //  .local: 123-4567
    //  .domestic: 123-456-7890
    //  .international: +1 234-567-8901
    static func usHyphen() -> [PhoneFormatRuleset] {
        return [
            PNFormatRuleset(.local, rules: [
                PNFormatRule(3, separator: .hyphen)
            ], maxLength: 7),
            PNFormatRuleset(.domestic, rules: [
                PNFormatRule(3, separator: .hyphen),
                PNFormatRule(6, separator: .hyphen)
            ], maxLength: 10),
            PNFormatRuleset(.international, rules: [
                PNFormatRule(0, separator: .plus),
                PNFormatRule(1, separator: .space),
                PNFormatRule(4, separator: .hyphen),
                PNFormatRule(7, separator: .hyphen)
            ], maxLength: 11)
        ]
    }

    // Formats phone numbers:
    //  .local: 123-4567
    //  .domestic: (123) 456-7890
    //  .international: +1 (234) 567-8901
    static func usParethesis() -> [PhoneFormatRuleset] {
        return [
            PNFormatRuleset(.local, rules: [
                PNFormatRule(3, separator: .hyphen)
            ], maxLength: 7),
            PNFormatRuleset(.domestic, rules: [
                PNFormatRule(0, separator: .parenthesisLH),
                PNFormatRule(3, separator: .parenthesisRH),
                PNFormatRule(3, separator: .space, priority: 1),
                PNFormatRule(6, separator: .hyphen)
            ], maxLength: 10),
            PNFormatRuleset(.international, rules: [
                PNFormatRule(0, separator: .plus),
                PNFormatRule(1, separator: .space),
                PNFormatRule(1, separator: .parenthesisLH, priority: 1),
                PNFormatRule(4, separator: .parenthesisRH),
                PNFormatRule(4, separator: .space, priority: 1),
                PNFormatRule(7, separator: .hyphen)
            ], maxLength: 11)
        ]
    }
}

```

If you are trying to format a string as a user enters a number into a textfield you can use a UITextFieldDelegate function something like this:

```Swift

extension ViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == phoneNumberField, let text = textField.text {

            // get current text + new character being entered
            var newStr = text + string

            // check if this is a backspace
            let isDeleting = (range.length > 0) && string.isEmpty
            if isDeleting == true {
                // trim last char for correct validation
                newStr.remove(at: newStr.index(before: newStr.endIndex))
            }

            // strip non-numeric characters
            let numberString = newStr.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

            // 11 character limit
            if numberString.count > 11 {
                return false
            }

            // don't update the field if formatting hasn't changed
            let formatted = formatter.format(number: numberString)
            if newStr != formatted {
                phoneNumberField.text = formatted
                return false
            }
        }

        return true
    }

}

```
