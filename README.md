This repository contains code, analyses, and documentation for flight-dynamics simulations,
including coordinate transforms (ECI⇄ECEF⇄ENZ⇄NED⇄Body), trajectory propagation, and stability
analyses.  

## Structure

flight-dynamics/
├── .github/
│   └── workflows/
│       └── ci.yml               # CI pipeline for building & testing
├── src/
│   ├── transforms/              # coordinate‐transform modules
│   ├── propagation/             # trajectory propagation algorithms
│   ├── performance/             # aerodynamic performance models
│   └── utils/                   # utility scripts & date/unit converters
├── notebooks/                   # exploration & visualization notebooks
├── data/                        # reference datasets & sample inputs
├── tests/                       # unit & regression tests (pytest)
├── docs/                        # detailed docs & derivations
├── .gitignore                   # files to ignore in Git
├── LICENSE                      # project license (MIT)
├── README.md                    # project overview & getting started
└── requirements.txt             # Python dependencies