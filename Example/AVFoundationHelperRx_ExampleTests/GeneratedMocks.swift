//
//  AVFoundationHelperProtocolRx.swift
//  AVFoundationHelperRx
//
//  Created by Nischal Hada on 6/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//
//swiftlint:disable all

import Cuckoo
import AVFoundationHelperRx
import RxSwift

class MockAVFoundationHelperProtocolRx: AVFoundationHelperProtocolRx, Cuckoo.ProtocolMock {

    typealias MocksType = AVFoundationHelperProtocolRx
    typealias Stubbing = __StubbingProxy_AVFoundationHelperProtocolRx
    typealias Verification = __VerificationProxy_AVFoundationHelperProtocolRx
    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)
    private var __defaultImplStub: AVFoundationHelperProtocolRx?

    func enableDefaultImplementation(_ stub: AVFoundationHelperProtocolRx) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    var authorizationStatus: Single<AuthorizationStatus> {
        get {
            return cuckoo_manager.getter("authorizationStatus", superclassCall:
                Cuckoo.MockManager.crashOnProtocolSuperclassCall(), defaultCall: __defaultImplStub!.authorizationStatus)
        }
    }

    var requestAccess: Single<Bool> {
        get {
            return cuckoo_manager.getter("requestAccess", superclassCall:
                Cuckoo.MockManager.crashOnProtocolSuperclassCall(), defaultCall: __defaultImplStub!.requestAccess)
        }
    }

    struct __StubbingProxy_AVFoundationHelperProtocolRx: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }

        var authorizationStatus: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAVFoundationHelperProtocolRx, Single<AuthorizationStatus>> {
            return .init(manager: cuckoo_manager, name: "authorizationStatus")
        }

        var requestAccess: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockAVFoundationHelperProtocolRx, Single<Bool>> {
            return .init(manager: cuckoo_manager, name: "requestAccess")
        }
    }

    struct __VerificationProxy_AVFoundationHelperProtocolRx: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        var authorizationStatus: Cuckoo.VerifyReadOnlyProperty<Single<AuthorizationStatus>> {
            return .init(manager: cuckoo_manager, name: "authorizationStatus", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }

        var requestAccess: Cuckoo.VerifyReadOnlyProperty<Single<Bool>> {
            return .init(manager: cuckoo_manager, name: "requestAccess", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
    }
}

class AVFoundationHelperProtocolRxStub: AVFoundationHelperProtocolRx {

    var authorizationStatus: Single<AuthorizationStatus> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Single<AuthorizationStatus>).self)
        }
    }

    var requestAccess: Single<Bool> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Single<Bool>).self)
        }
    }
}
