//! `scan_substitution_spans` walks `chars` (char indices) but needs a byte
//! offset when it slices `raw`. Passing the char index straight into
//! `&raw[cursor + 1..]` panicked as soon as a `$(` was preceded by any
//! multi-byte character ("start byte index N is not a char boundary").
//!
//! Covers the non-ASCII prefix case in double quotes, plain words and inside a
//! parameter expansion.

use std::process::Command;

fn rubash(script: &str) -> String {
    let output = Command::new(env!("CARGO_BIN_EXE_rubash"))
        .arg("-c")
        .arg(script)
        .output()
        .expect("run rubash");
    String::from_utf8_lossy(&output.stdout).into_owned()
}

#[test]
fn cjk_before_command_substitution_in_double_quotes() {
    assert_eq!(
        rubash("echo \"该文件（应为）: $(echo hi)\""),
        "该文件（应为）: hi\n"
    );
}

#[test]
fn cjk_around_command_substitution() {
    assert_eq!(rubash("echo \"abc（x）: $(echo hi)\""), "abc（x）: hi\n");
}

#[test]
fn cjk_before_parameter_expansion_in_double_quotes() {
    assert_eq!(rubash("v=1\necho \"（应为）: ${v}\""), "（应为）: 1\n");
}

#[test]
fn cjk_prefix_without_any_substitution() {
    assert_eq!(rubash("echo \"纯中文\""), "纯中文\n");
}
