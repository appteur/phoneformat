//
//  PhoneFormatType.swift
//  PhoneFormat
//
//  Created by Seth on 7/11/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

/// Defines the three different types of formatting phone numbers use
///
/// - local: Numbers used locally.
/// - domestic: Numbers used locally including area codes.
/// - international: Numbers used internationally with country codes.
public enum PhoneFormatType {
    case local
    case domestic
    case international
}

public func ==(lhs: PhoneFormatType, rhs: PhoneFormatType) -> Bool {
    switch (lhs, rhs) {
    case (.local, .local),
         (.domestic, .domestic),
         (.international, .international):
        return true
    default:
        return false
    }
}
