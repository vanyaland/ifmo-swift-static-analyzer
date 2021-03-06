/**
 * Copyright (c) 2018 Ivan Magda
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import SourceKittenFramework

/// "Print lint warnings and errors for the Swift files in the current directory".
public struct Linter {

    // MARK: Instance Variables

    private let file: File

    // MARK: Init

    /**
     Initialize a Linter by passing in a File.

     :param: file File to lint.
     */
    public init(file: File) {
        self.file = file
    }

    // MARK: Public API

    public var stringViolations: [StyleViolation] {
        let lines = file.contents.lines()

        var violations = file.lineLengthViolations(lines: lines)
        violations.append(contentsOf: file.leadingWhitespaceViolations(contents: file.contents))
        violations.append(contentsOf: file.trailingLineWhitespaceViolations(lines: lines))
        violations.append(contentsOf: file.trailingNewlineViolations(contents: file.contents))
        violations.append(contentsOf: file.forceCastViolations(file: file))
        violations.append(contentsOf: file.fileLengthViolations(lines: lines))

        return violations
    }

}
