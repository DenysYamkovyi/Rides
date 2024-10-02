//
//  CarsListViewModelTests.swift
//  RidesTests
//
//  Created by macbook pro on 2024-10-02.
//

import XCTest
import Combine
@testable import Rides

final class CarsListViewModelTests: XCTestCase {
    var viewModel: CarsListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CarsListViewModel()
    }

    func testValidation_ValidInput() {
        viewModel.listSize = "50" // Valid input
        viewModel.didTapFetchCarsList()
        XCTAssertEqual(viewModel.error, "", "Expected no error message")
    }

    func testValidation_InvalidInput_TooLow() {
        viewModel.listSize = "0" // Invalid input
        viewModel.didTapFetchCarsList()
        XCTAssertEqual(viewModel.error, "Please enter a value between 1 and 100", "Expected specific error message")
    }

    func testValidation_InvalidInput_TooHigh() {
        viewModel.listSize = "101" // Invalid input
        viewModel.didTapFetchCarsList()
        XCTAssertEqual(viewModel.error, "Please enter a value between 1 and 100", "Expected specific error message")
    }

    func testValidation_InvalidInput_NonInteger() {
        viewModel.listSize = "abc" // Invalid input
        viewModel.didTapFetchCarsList()
        XCTAssertEqual(viewModel.error, "Please enter a value between 1 and 100", "Expected specific error message")
    }
}
