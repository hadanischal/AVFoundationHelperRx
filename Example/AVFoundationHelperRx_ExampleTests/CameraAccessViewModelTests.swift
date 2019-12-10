//
//  CameraAccessViewModelTests.swift
//  AVFoundationHelperRx_Tests
//
//  Created by Nischal Hada on 7/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//
//swiftlint:disable function_body_length

import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxSwift
import AVFoundationHelperRx
@testable import AVFoundationHelperRx_Example

class CameraAccessViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: CameraAccessViewModel!
        var mockAVFoundation: MockAVFoundationHelperProtocolRx!
        var testScheduler: TestScheduler!

        describe("CameraAccessViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)

                mockAVFoundation = MockAVFoundationHelperProtocolRx()
                stub(mockAVFoundation, block: { (stub) in
                    when(stub.authorizationStatus).get.thenReturn(Single.just(.authorized))
                    when(stub.requestAccess).get.thenReturn(Single.just(true))
                })
                testViewModel = CameraAccessViewModel(avFoundation: mockAVFoundation)
            }

            afterEach {
                reset(mockAVFoundation)
            }

            describe("when imageRequested i.e button is tapped", {
                var tapInput: Observable<Void>!

                beforeEach {
                    tapInput = testScheduler.createColdObservable([Recorded.next(300, ())]).asObservable()
                }

                context("when authorizationStatus is authorized ", {
                    beforeEach {
                        let status = testScheduler.createColdObservable([Recorded.next(10, AuthorizationStatus.authorized), Recorded.completed(20)]).asSingle()
                        stub(mockAVFoundation, block: { (stub) in
                            when(stub.authorizationStatus.get).thenReturn(status)
                        })
                    }
                    it("emits launchCamera", closure: {
                        let testObservable = testViewModel.transformInput(CameraButtonTaps: tapInput)
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(520, CameraAccessRoute.showCameraReader)]
                        XCTAssertEqual(res.events, correctResult)
                    })
                })

                context("when authorizationStatus is denied ", {

                    beforeEach {
                        let status = testScheduler.createColdObservable([Recorded.next(10, AuthorizationStatus.denied), .completed(20)]).asSingle()
                        stub(mockAVFoundation, block: { (stub) in
                            when(stub.authorizationStatus.get).thenReturn(status)
                        })
                    }
                    it("emits alertCameraAccessNeeded", closure: {
                        let testObservable = testViewModel.transformInput(CameraButtonTaps: tapInput)
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(520, CameraAccessRoute.alertCameraAccessNeeded)]
                        XCTAssertEqual(res.events, correctResult)
                    })
                })

                context("when authorizationStatus is restricted ", {
                    beforeEach {
                        let status = testScheduler.createColdObservable([Recorded.next(10, AuthorizationStatus.restricted), Recorded.completed(20)]).asSingle()
                        stub(mockAVFoundation, block: { (stub) in
                            when(stub.authorizationStatus.get).thenReturn(status)
                        })
                    }
                    it("emits alertCameraAccessNeeded", closure: {
                        let testObservable = testViewModel.transformInput(CameraButtonTaps: tapInput)
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(520, CameraAccessRoute.alertCameraAccessNeeded)]
                        XCTAssertEqual(res.events, correctResult)
                    })
                })

                describe("when authorizationStatus is notDetermined ", {
                    context("when requestAccess is authorized ", {
                        beforeEach {

                            let status = testScheduler.createColdObservable([Recorded.next(10, AuthorizationStatus.notDetermined), Recorded.completed(20)]).asSingle()
                            let isAccess = testScheduler.createColdObservable([Recorded.next(10, true), Recorded.completed(20)]).asSingle()
                            stub(mockAVFoundation, block: { (stub) in
                                when(stub.authorizationStatus.get).thenReturn(status)
                                when(stub.requestAccess.get).thenReturn(isAccess)
                            })
                        }
                        it("emits showQRCodeReader", closure: {
                            let testObservable = testViewModel.transformInput(CameraButtonTaps: tapInput)
                            let res = testScheduler.start { testObservable }
                            verify(mockAVFoundation).requestAccess.get()
                            expect(res.events.count).to(equal(1))
                            let correctResult = [Recorded.next(540, CameraAccessRoute.showCameraReader)]
                            XCTAssertEqual(res.events, correctResult)
                        })
                    })

                    context("when requestAccess is denied ", {
                        beforeEach {

                            let status = testScheduler.createColdObservable([Recorded.next(10, AuthorizationStatus.notDetermined), Recorded.completed(20)]).asSingle()
                            let isAccess = testScheduler.createColdObservable([Recorded.next(10, false), Recorded.completed(20)]).asSingle()
                            stub(mockAVFoundation, block: { (stub) in
                                when(stub.authorizationStatus.get).thenReturn(status)
                                when(stub.requestAccess.get).thenReturn(isAccess)
                            })
                        }
                        it("emits alertCameraAccessNeeded", closure: {
                            let testObservable = testViewModel.transformInput(CameraButtonTaps: tapInput)
                            let res = testScheduler.start { testObservable }
                            verify(mockAVFoundation).requestAccess.get()
                            expect(res.events.count).to(equal(1))
                            let correctResult = [Recorded.next(540, CameraAccessRoute.alertCameraAccessNeeded)]
                            XCTAssertEqual(res.events, correctResult)
                        })
                    })
                })
            })
        }
    }
}
