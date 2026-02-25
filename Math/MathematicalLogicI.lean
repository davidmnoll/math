/-

Using text:
https://www.math.wustl.edu/~victor/classes/ma5051/rags100514.pdf

-/

set_option autoImplicit false


namespace MathematicalLogicI



namespace Ch1


inductive BinConn where
  | and | or | imp
  deriving DecidableEq, Repr

inductive Formula
| letter : Char -> Formula
| not : Formula → Formula
| bin : BinConn -> Formula → Formula → Formula


def len : Formula -> Nat
| .letter _ => 1
| .not x => (len x) + 1
| .bin _ x y => (len x) + (len y) + 3

def varCount : Formula -> Nat
| .letter _ => 1
| .not x => varCount x
| .bin _ x y => varCount x + varCount y

def binCount: Formula -> Nat
| .letter _ => 0
| .not x => binCount x
| .bin _ x y => binCount x + binCount y + 1

def notCount : Formula → Nat
  | .letter _ => 0
  | .not x => notCount x + 1
  | .bin _ x y  => notCount x + notCount y

theorem varCount_eq (x : Formula) :
  varCount x = binCount x + 1 := by induction x with
  | letter _ =>
    -- goal:
    -- 1 = 0 + 1
    simp [varCount, binCount]
  | not x ih =>
      -- ih : varCount φ = binCount φ + 1
      -- goal:
      -- varCount φ = binCount φ + 1
      simpa [varCount, binCount] using ih

  | bin c x y ihx ihy =>
      -- ihx : varCount x = binCount x + 1
      -- ihy : varCount y = binCount y + 1
      --
      -- goal:
      -- varCount x + varCount y
      --   = (binCount x + binCount y + 1) + 1

      simp [varCount, binCount, ihx, ihy, Nat.add_comm,
            Nat.add_left_comm, Nat.add_assoc]

theorem lenFormula : Nat -> Nat -> Nat :=





end Ch1

end MathematicalLogicI
