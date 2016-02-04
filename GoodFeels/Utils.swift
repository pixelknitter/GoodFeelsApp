//
//  Utils.swift
//  GoodFeels
//
//  A helper to get the right queues fast.
//
//  Created by Edward Freeman on 2/2/16.
//  Copyright © 2016 NinjaSudo LLC. All rights reserved.
//

private let concurrentMemoryQueue = dispatch_queue_create(
    "com.ninjasudo.GoodFeels.outOfMemoryQueue", DISPATCH_QUEUE_CONCURRENT)

var GlobalMainQueue: dispatch_queue_t {
    return dispatch_get_main_queue()
}

var GlobalUserInteractiveQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)
}

var GlobalUserInitiatedQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
}

var GlobalUtilityQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)
}

var GlobalBackgroundQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)
}

// For Demo Purposes
func crashStackOverflow() {
    // Allocate some memory on the stack to make the stack overflow
    // go faster
    let myIntegers = Array.init(count: 2048, repeatedValue: 0)
    
    crashStackOverflow()
}

func outOfMemoryCrash() {
    dispatch_async(concurrentMemoryQueue) {
        while true { // simply never stop adding image objects
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
            UIImage.initialize()
        }
    }
}