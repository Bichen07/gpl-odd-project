from dataclasses import dataclass
from typing import Any, Literal, Sequence, Union

from ax.service.ax_client import TParameterization

CompareLiteral = Literal["greaterThan", "lessThan"]


@dataclass
class SafetyMetricInfo:
    threshold: float
    rule: CompareLiteral


@dataclass
class SafetyRequirement:
    preventable_condition: dict[str, dict[str, Any]]
    metrics: dict[str, SafetyMetricInfo]


@dataclass
class ConfigData:
    batch_id: str


@dataclass
class RegisterData:
    batch_id: str
    trial_index: int
    outcome: dict[str, int | float | str | None] | None
    esmini_dat_id: str


@dataclass
class SuggestData:
    trial_index: int
    parameters: TParameterization | None


@dataclass
class NewConfigFileData:
    filepath: str
    trial_index: int


def compare(lhs, rule: CompareLiteral, rhs):
    if rule == "greaterThan":
        return lhs > rhs
    elif rule == "lessThan":
        return lhs < rhs
    raise RuntimeError("Rule not supported")
