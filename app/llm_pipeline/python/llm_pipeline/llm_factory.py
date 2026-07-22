"""
Shared LLM construction for cluster interpretation (OpenAI + Google Gemini).

Mirrors xosc_gen/models/llm_factory.py so the same model ids and env vars work
in both projects.
"""
from __future__ import annotations

import os
from typing import Any, Optional

# Default for cluster interpretation CLI and ClusterInterpreter
DEFAULT_MODEL = "gemini-2.5-flash"

# Friendly aliases (lowercase keys) for CLI typos / spaced names
_MODEL_ALIASES = {
    "gemini flash 2.5": "gemini-2.5-flash",
    "gemini 2.5 flash": "gemini-2.5-flash",
    "gemini-flash-2.5": "gemini-2.5-flash",
    "gemini 2.5": "gemini-2.5-flash",
    "gemini flash 2.0": "gemini-2.0-flash",
    "gemini 2.0 flash": "gemini-2.0-flash",
}


def normalize_model_name(model: str) -> str:
    """Normalize model id; accept spaced aliases like ``gemini flash 2.5``."""
    raw = (model or "").strip()
    if not raw:
        return DEFAULT_MODEL
    key = raw.lower()
    if key in _MODEL_ALIASES:
        return _MODEL_ALIASES[key]
    # Already a valid API id (e.g. gemini-2.5-flash, gpt-4o)
    if key.startswith("gemini") and " " in key:
        # Last resort: user passed unquoted words — unlikely to be correct
        return key.replace(" ", "-")
    return raw


def is_gemini_model(model: str) -> bool:
    return normalize_model_name(model).lower().startswith("gemini")


def is_openai_model(model: str) -> bool:
    name = normalize_model_name(model).lower()
    return name.startswith("gpt")


def llm_api_key_for_model(model: str, api_key: Optional[str] = None) -> Optional[str]:
    """Return API key for the model provider (explicit arg overrides env)."""
    if api_key and api_key.strip():
        return api_key.strip()
    name = normalize_model_name(model)
    if is_gemini_model(name):
        return os.getenv("GOOGLE_API_KEY", "").strip() or None
    if is_openai_model(name):
        return os.getenv("OPENAI_API_KEY", "").strip() or None
    return None


def has_llm_credentials(model: str, api_key: Optional[str] = None) -> bool:
    return bool(llm_api_key_for_model(model, api_key))


def api_key_env_hint(model: str) -> str:
    if is_gemini_model(model):
        return "GOOGLE_API_KEY"
    if is_openai_model(model):
        return "OPENAI_API_KEY"
    return "GOOGLE_API_KEY or OPENAI_API_KEY"


def create_interpretation_llm(
    model_name: str,
    api_key: Optional[str] = None,
    temperature: float = 0.1,
    top_p: float = 0.95,
    max_tokens: int = 8192,
) -> Any:
    """Build a LangChain chat model for multimodal cluster interpretation."""
    name = normalize_model_name(model_name)
    key = llm_api_key_for_model(name, api_key)

    if name == "gpt-4o" or name.startswith("gpt-4"):
        from langchain_openai import ChatOpenAI

        return ChatOpenAI(
            model=name,
            api_key=key,
            temperature=temperature,
            max_tokens=max_tokens,
        )
    if name == "gpt-5" or name.startswith("gpt-5"):
        from langchain_openai import ChatOpenAI

        return ChatOpenAI(model=name, api_key=key, max_tokens=max_tokens)

    if name.startswith("gemini"):
        try:
            from langchain_google_genai import ChatGoogleGenerativeAI
        except ImportError as e:
            raise ImportError(
                "Gemini requires langchain-google-genai. "
                "Install: pip install langchain-google-genai"
            ) from e

        return ChatGoogleGenerativeAI(
            model=name,
            google_api_key=key,
            temperature=temperature,
            top_p=top_p,
            max_output_tokens=max_tokens,
            convert_system_message_to_human=True,
        )

    raise ValueError(
        f"Unsupported model: {model_name!r} (normalized: {name!r}). "
        f"Use gemini-* (GOOGLE_API_KEY) or gpt-* (OPENAI_API_KEY)."
    )
