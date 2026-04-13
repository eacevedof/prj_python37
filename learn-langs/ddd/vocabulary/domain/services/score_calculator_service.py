from typing import final


@final
class ScoreCalculatorService:
    """Servicio de dominio para calcular score de respuestas."""

    @staticmethod
    def calculate(expected: str, user_input: str) -> float:
        """
        Calcula score de 0.0 a 1.0 basado en similitud Levenshtein.

        Args:
            expected: Texto esperado (traducción correcta).
            user_input: Texto introducido por el usuario.

        Returns:
            0.0  - Sin respuesta o completamente incorrecto (<50% similar)
            0.1-0.9 - Parcialmente correcto
            1.0  - Exactamente correcto
        """
        if not user_input or not user_input.strip():
            return 0.0

        expected_clean = expected.lower().strip()
        input_clean = user_input.lower().strip()

        if expected_clean == input_clean:
            return 1.0

        distance = ScoreCalculatorService._levenshtein_distance(expected_clean, input_clean)
        max_len = max(len(expected_clean), len(input_clean))

        if max_len == 0:
            return 0.0

        similarity = 1 - (distance / max_len)

        # Umbral mínimo: si es menos del 50% similar, es 0
        if similarity < 0.5:
            return 0.0

        return round(similarity, 2)

    @staticmethod
    def _levenshtein_distance(s1: str, s2: str) -> int:
        """Calcula la distancia de Levenshtein entre dos strings."""
        if len(s1) < len(s2):
            return ScoreCalculatorService._levenshtein_distance(s2, s1)

        if len(s2) == 0:
            return len(s1)

        previous_row = range(len(s2) + 1)

        for i, c1 in enumerate(s1):
            current_row = [i + 1]
            for j, c2 in enumerate(s2):
                insertions = previous_row[j + 1] + 1
                deletions = current_row[j] + 1
                substitutions = previous_row[j] + (c1 != c2)
                current_row.append(min(insertions, deletions, substitutions))
            previous_row = current_row

        return previous_row[-1]

    @staticmethod
    def score_to_quality(score: float) -> int:
        """
        Convierte score (0.0-1.0) a quality (0-5) para SM-2.

        Args:
            score: Score de 0.0 a 1.0

        Returns:
            Quality de 0 a 5:
            - 0-2: Respuesta incorrecta (requiere repetición)
            - 3: Respuesta correcta con dificultad
            - 4: Respuesta correcta con algo de duda
            - 5: Respuesta perfecta
        """
        if score >= 1.0:
            return 5
        elif score >= 0.9:
            return 4
        elif score >= 0.7:
            return 3
        elif score >= 0.5:
            return 2
        elif score > 0.0:
            return 1
        else:
            return 0
