"""Integration tests for VerifyFileSignatureController."""

import hashlib
from pathlib import Path

from ddd.file_checker.infrastructure.controllers import VerifyFileSignatureController
from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum


class TestVerifyFileSignatureController:
    """VerifyFileSignatureController tests."""

    @classmethod
    def setup_class(cls) -> None:
        """Setup for all tests."""
        cls.test_file = Path("ddd/file_checker/domain/exceptions/file_checker_exception.py")
        assert cls.test_file.exists(), f"Test file not found: {cls.test_file}"

    def test_invoke_valid_hash_returns_200(self) -> None:
        """Valid file verification should return 200 with data."""
        with open(self.test_file, "rb") as f:
            expected_hash = hashlib.sha256(f.read()).hexdigest()

        controller = VerifyFileSignatureController.get_instance()
        response = controller.invoke(
            file_path=str(self.test_file),
            expected_hash=expected_hash,
            algorithm="sha256"
        )

        assert response["code"] == ResponseCodeEnum.OK
        assert "data" in response
        assert response["data"]["is_valid"] is True

    def test_invoke_tampered_hash_returns_200_not_valid(self) -> None:
        """Tampered hash should return 200 but is_valid=False."""
        controller = VerifyFileSignatureController.get_instance()
        response = controller.invoke(
            file_path=str(self.test_file),
            expected_hash="a" * 64,
            algorithm="sha256"
        )

        assert response["code"] == ResponseCodeEnum.OK
        assert response["data"]["is_valid"] is False

    def test_invoke_invalid_algorithm_returns_400(self) -> None:
        """Invalid algorithm should return 400."""
        controller = VerifyFileSignatureController.get_instance()
        response = controller.invoke(
            file_path=str(self.test_file),
            expected_hash="a" * 64,
            algorithm="invalid_algo"
        )

        assert response["code"] == ResponseCodeEnum.BAD_REQUEST
        assert "error" in response

    def test_invoke_file_not_found_returns_400(self) -> None:
        """Non-existent file should return 400."""
        controller = VerifyFileSignatureController.get_instance()
        response = controller.invoke(
            file_path="/nonexistent/file.bin",
            expected_hash="a" * 64,
            algorithm="sha256"
        )

        assert response["code"] == ResponseCodeEnum.BAD_REQUEST
        assert "error" in response

    def test_invoke_wrong_hash_length_returns_400(self) -> None:
        """Hash with wrong length should return 400."""
        controller = VerifyFileSignatureController.get_instance()
        response = controller.invoke(
            file_path=str(self.test_file),
            expected_hash="abc",
            algorithm="sha256"
        )

        assert response["code"] == ResponseCodeEnum.BAD_REQUEST
        assert "error" in response

    def test_invoke_md5_algorithm(self) -> None:
        """MD5 algorithm should work."""
        with open(self.test_file, "rb") as f:
            expected_hash = hashlib.md5(f.read()).hexdigest()

        controller = VerifyFileSignatureController.get_instance()
        response = controller.invoke(
            file_path=str(self.test_file),
            expected_hash=expected_hash,
            algorithm="md5"
        )

        assert response["code"] == ResponseCodeEnum.OK
        assert response["data"]["is_valid"] is True

    def test_invoke_sha512_algorithm(self) -> None:
        """SHA512 algorithm should work."""
        with open(self.test_file, "rb") as f:
            expected_hash = hashlib.sha512(f.read()).hexdigest()

        controller = VerifyFileSignatureController.get_instance()
        response = controller.invoke(
            file_path=str(self.test_file),
            expected_hash=expected_hash,
            algorithm="sha512"
        )

        assert response["code"] == ResponseCodeEnum.OK
        assert response["data"]["is_valid"] is True

    def test_invoke_default_algorithm_is_sha256(self) -> None:
        """Default algorithm should be SHA256."""
        with open(self.test_file, "rb") as f:
            expected_hash = hashlib.sha256(f.read()).hexdigest()

        controller = VerifyFileSignatureController.get_instance()
        response = controller.invoke(
            file_path=str(self.test_file),
            expected_hash=expected_hash
        )

        assert response["code"] == ResponseCodeEnum.OK
        assert response["data"]["algorithm"] == "sha256"


def run_all_tests() -> None:
    """Run all controller tests."""
    test_suite = TestVerifyFileSignatureController()
    test_suite.setup_class()

    tests = [
        ("test_invoke_valid_hash_returns_200", test_suite.test_invoke_valid_hash_returns_200),
        ("test_invoke_tampered_hash_returns_200_not_valid", test_suite.test_invoke_tampered_hash_returns_200_not_valid),
        ("test_invoke_invalid_algorithm_returns_400", test_suite.test_invoke_invalid_algorithm_returns_400),
        ("test_invoke_file_not_found_returns_400", test_suite.test_invoke_file_not_found_returns_400),
        ("test_invoke_wrong_hash_length_returns_400", test_suite.test_invoke_wrong_hash_length_returns_400),
        ("test_invoke_md5_algorithm", test_suite.test_invoke_md5_algorithm),
        ("test_invoke_sha512_algorithm", test_suite.test_invoke_sha512_algorithm),
        ("test_invoke_default_algorithm_is_sha256", test_suite.test_invoke_default_algorithm_is_sha256),
    ]

    passed = 0
    failed = 0

    for test_name, test_func in tests:
        try:
            test_func()
            print(f"  PASS: {test_name}")
            passed += 1
        except AssertionError as e:
            print(f"  FAIL: {test_name} - {e}")
            failed += 1
        except Exception as e:
            print(f"  ERROR: {test_name} - {e}")
            failed += 1

    print("\n" + "=" * 70)
    print(f"Results: {passed} passed, {failed} failed")
    print("=" * 70)

    return failed == 0


if __name__ == "__main__":
    success = run_all_tests()
    exit(0 if success else 1)
