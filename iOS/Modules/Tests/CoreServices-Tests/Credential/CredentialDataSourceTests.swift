
// TODO: Need a host application for test.
// try to study how to do this kind of test inside module

////
////  File.swift
////
////
////  Created by Fábio Nogueira de Almeida on 09/09/20.
////
//
//@testable import CoreServices
//import Moya
//import XCTest
//
//class CredentialDataSourceTests: XCTestCase {
//
//	let datasource = CredentialDataSource()
//
//	// MARK: - Lifecycle
//
//	override func setUp() {
//		super.setUp()
//
//	}
//
//	// MARK: - Tests
//
//	func testShouldVerifyIfCredentialWillBeSaved() {
//		let accessToken = "DASDASD23DAW"
//		let refreshToken = "019123812123ADWD22312356"
//		let credential = Credential(accessToken: accessToken, refreshToken: refreshToken)
//
//		datasource.save(credential)
//
//		let sutCredential = datasource.getCredential()
//		XCTAssert(sutCredential?.accessToken == accessToken)
//		XCTAssert(sutCredential?.refreshToken == refreshToken)
//	}
//}
//
//
