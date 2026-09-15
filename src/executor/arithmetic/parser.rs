#[path = "cursor.rs"]
mod cursor;
#[path = "expression.rs"]
mod expression;
#[path = "factor.rs"]
mod factor;
#[path = "lvalue.rs"]
mod lvalue;
#[path = "value.rs"]
mod value;

use std::cell::Cell;
use std::collections::HashMap;

pub(super) struct ConditionalArithParser<'a> {
    pub(super) input: &'a [u8],
    pub(super) pos: usize,
    pub(super) env_vars: &'a mut HashMap<String, String>,
    pub(super) resolving: Vec<String>,
    pub(super) random_state: Option<&'a Cell<u32>>,
    pub(super) error_category: Option<super::ArithmeticErrorCategory>,
}

#[derive(Clone)]
pub(super) enum ArithLValue {
    Scalar(String),
    Indexed {
        name: String,
        index: i128,
    },
    /// Array element with a raw subscript expression that must be evaluated
    /// lazily *after* the RHS of an assignment, matching GNU expr.c:1395-1401
    /// where `expr_streval` is skipped when the next token is `=`. The subscript
    /// is re-evaluated at bind time, so side effects in the RHS (e.g.
    /// `a[n]=++n`) are visible to the subscript.
    IndexedRaw {
        name: String,
        subscript: String,
    },
    Assoc {
        name: String,
        key: String,
    },
}
