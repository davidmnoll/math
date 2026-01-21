/-
Using text
https://www.fecundity.com/codex/forallx.pdf
-/

namespace PropLogic


namespace Ch1

/-
Learned:
- tautology means something that's logically true no matter what
- sentential logic = logic with sentences
- quantified logic = objects, properties & relations
-/
inductive Sentence : Type
| is
| not

def partA : List Sentence := [
  .is, -- 1. England is smaller than China.
  .is, -- 2. Greenland is south of Jerusalem.
  .not, -- 3. Is New Jersey east of Wisconsin?
  .is, -- 4. The atomic number of helium is 2.
  .is, -- 5. The atomic number of helium is π.
  .is, -- 6. I hate overcooked noodles.
  .not, -- 7. Blech! Overcooked noodles!
  .is, -- 8. Overcooked noodles are disgusting.
  .not, -- 9. Take your time.
  .is, -- 10. This is the last question.
]

inductive StmtType : Type
| tautology
| contradiction
| contingent

-- Part B For each of the following: Is it a tautology, a contradiction, or a contingent sentence?
def partB : List StmtType := [
  .contingent, -- 1. Caesar crossed the Rubicon.
  .contingent, -- 2. Someone once crossed the Rubicon.
  .contingent, -- 3. No one has ever crossed the Rubicon.
  .tautology, -- 4. If Caesar crossed the Rubicon, then someone has.
  .contradiction, -- 5. Even though Caesar crossed the Rubicon, no one has ever crossed the Rubicon.
  .contingent, -- 6. If anyone has ever crossed the Rubicon, it was Caesar.
]

/-
G1 There are at least four giraffes at the wild animal park.
G2 There are exactly seven gorillas at the wild animal park.
G3 There are not more than two martians at the wild animal park.
G4 Every giraffe at the wild animal park is a martian.
-/

inductive Consistent : Type
| is
| not

--  Look back at the sentences G1–G4 on p. 11, and consider each of the following sets of sentences. Which are consistent? Which are inconsistent?
def partC : List Consistent := [
  .is, -- 1. G2, G3, and G4
  .not, -- 2. G1, G3, and G4
  .not, -- 3. G1, G2, and G4
  .is, -- 4. G1, G2, and G3
]

inductive Possible : Type
| is
| not
-- Which of the following is possible? If it is possible, give an example. If it is not possible, explain why.
def partD : List (Prod Possible String) := [
  (.is, "Pizza is food; food is cold; therefore pizza is cold => A is B; B (incorrect) is C; A is C"), -- 1. A valid argument that has one false premise and one true premise
  (.is, "Pizza is food; food is cold; therefore pizza is cold => A is B; B (incorrect) is C; A is C"), --  2. A valid argument that has a false conclusion
-- #3 incorrect first try  (.not, "A valid argument cannot lead to a contradiction.  Lack of contradictions is definitionally part of validity"), -- 3. A valid argument, the conclusion of which is a contradiction
  (.is, "Nobody ate the pizza and Charlie ate pizza.  Therefore nobody ate pizza and charlie at pizza => A and B; therefore A and B"), -- 3. A valid argument, the conclusion of which is a contradiction
-- #4 incorrect first try (.is, "Pizza is food; food is cold; cold things are not food; If someone eats pizza, then pizza is eaten"), -- 4. An invalid argument, the conclusion of which is a tautology
  (.not, "A tautology requires a valid arguments because a contradiction would render the argument's conclusion logically false"), -- 4. An invalid argument, the conclusion of which is a tautology

  (.not, "Lack of contingency is required for tautology by defintion"), -- 5. A tautology that is contingent
  (.is, "If someone eats pizza, then pizza is eaten; If someone did not not eat pizza, then someone ate pizza => if A then B; if not not A, then B"), --6. Two logically equivalent sentences, both of which are tautologies
  (.not, " Difference in distinguishable logical properties such as tautology or contingency directly contradicts the property of logical equivalence"), --7. Two logically equivalent sentences, one of which is a tautology and one of which is contingent
-- #8 incorrect first try (.not, " A contradiction directly implies distinguishable difference in logical meaning"), -- 8. Two logically equivalent sentences that together are an inconsistent set
  (.is, "{A1 A and not A  A2 A and not A}"), -- 8. Two logically equivalent sentences that together are an inconsistent set
  (.not, "A set of sentences which contains a contradiciton is inconsistent by definition"), -- 9. A consistent set of sentences that contains a contradiction
  (.is, "Pizza is food; food is cold; cold things are not food;If someone eats pizza, then pizza is eaten => A is B; B is C; C is not A; if D then D"), -- 10. An inconsistent set of sentences that contains a tautology
]


def ch1 : Unit := Id.run do
  _ <- partA
  _ <- partB
  _ <- partC
  _ <- partD

end Ch1



namespace Ch2

axiom M : Prop -- M: Those creatures are men in suits.
axiom C : Prop -- C: Those creatures are chimpanzees.
axiom G : Prop -- G: Those creatures are gorillas.

def partA : List Prop := [
  Not M, -- 1. Those creatures are not men in suits.
  (Or M (Not M)), -- 2. Those creatures are men in suits, or they are not.
  (Or C G),-- 3. Those creatures are either gorillas or chimpanzees.
  (And (Not C) (Not G)), -- 4. Those creatures are neither gorillas nor chimpanzees.
  (C -> Not (Or M G)), -- 5. If those creatures are chimpanzees, then they are neither gorillas nor men in suits.
  Or M (Or C G) -- 6. Unless those creatures are men in suits, they are either chimpanzees or they are gorillas.
]

axiom A : Prop -- A: Mister Ace was murdered.
  axiom B : Prop -- B: The butler did it.
  axiom C' : Prop -- C: The cook did it.
axiom D : Prop -- D: The Duchess is lying.
axiom E : Prop -- E: Mister Edge was murdered.
axiom F : Prop -- F: The murder weapon was a frying pan.


def partB : List Prop := [
  Or A E, -- 1. Either Mister Ace or Mister Edge was murdered.
  A -> C', -- 2. If Mister Ace was murdered, then the cook did it.
  E -> Not C', -- 3. If Mister Edge was murdered, then the cook did not do it.
  Or B D, -- 4. Either the butler did it, or the Duchess is lying.
  -- Incorrect first response: D -> C', -- 5. The cook did it only if the Duchess is lying.
  C' -> D, -- 5. The cook did it only if the Duchess is lying.
  F -> C', -- 6. If the murder weapon was a frying pan, then the culprit must have been the cook.
  Not F -> Or B C', -- 7. If the murder weapon was not a frying pan, then the culprit was either the cook or the butler.
  And (A -> Not E) (Not E -> A), -- 8. Mister Ace was murdered if and only if Mister Edge was not murdered.
  Or D E, -- 9. The Duchess is lying, unless it was Mister Edge who was murdered.
  A -> F, -- 10. If Mister Ace was murdered, he was done in with a frying pan.
  -- Incorrect first response: C' -> B, -- 11. Since the cook did it, the butler did not.
  C' -> Not B, -- 11. Since the cook did it, the butler did not.
  D, -- 12. Of course the Duchess is lying!
]


end Ch2

end PropLogic
