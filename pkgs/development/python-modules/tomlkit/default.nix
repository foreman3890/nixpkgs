{ lib
, buildPythonPackage
, fetchPypi
, isPy27
, enum34
, functools32, typing ? null
, pytestCheckHook
, pyaml
, poetry-core
}:

buildPythonPackage rec {
  pname = "tomlkit";
  version = "0.11.8";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-kzD8f6odtntUGyjmIBjBfSC+czF30pChOyTGLRYU4MM=";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs =
    lib.optionals isPy27 [ enum34 functools32 ]
    ++ lib.optional isPy27 typing;

  nativeCheckInputs = [
    pyaml
    pytestCheckHook
  ];

  pythonImportsCheck = [ "tomlkit" ];

  meta = with lib; {
    homepage = "https://github.com/sdispater/tomlkit";
    changelog = "https://github.com/sdispater/tomlkit/blob/${version}/CHANGELOG.md";
    description = "Style-preserving TOML library for Python";
    license = licenses.mit;
    maintainers = with maintainers; [ jakewaksbaum ];
  };
}
