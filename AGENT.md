# AGENT.md - Guidelines for gtasks-md

## Commands
- **Run tests**: `python -m unittest app/test_pandoc.py`
- **Run single test**: `python -m unittest app.test_pandoc.TestPandocConversion.test_task_list`
- **Install dependencies**: `pip install -r requirements.txt`
- **Run application**: `./runner.py --help`
- **Development with Nix**: `nix-shell`

## Code Style
- **Python version**: 3.11+
- **Imports**: Standard library first, then third-party packages, then local modules
- **Error handling**: Use explicit SyntaxError for parsing errors
- **Naming**: Snake case for functions/variables, PascalCase for classes
- **Type annotations**: Use full type hints (list[TaskList] instead of List[TaskList])
- **Pattern matching**: Use structural pattern matching (match/case) for parsing
- **Documentation**: Docstrings for public functions
- **License**: Apache License 2.0 header at top of each file