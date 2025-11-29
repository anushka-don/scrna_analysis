# Single-Cell Transcriptomic Analysis of Pancreatic Cancer Liver Metastasis

## Overview

This project reproduces and explores single-cell RNA sequencing (scRNA-seq) findings from the study:

**Zhang et al., 2023**
*Single cell transcriptomic analyses implicate an immunosuppressive tumor microenvironment in pancreatic cancer liver metastasis*
*(Nature Communications, 2023)*
[https://doi.org/10.1038/s41467-023-40727-7](https://doi.org/10.1038/s41467-023-40727-7)

The analysis investigates how immune and stromal cells contribute to the metastatic microenvironment of pancreatic cancer in the liver.

---

## Background

Pancreatic ductal adenocarcinoma (PDAC) is an aggressive cancer with frequent liver metastasis.
Single-cell transcriptomics provides a way to dissect the tumor microenvironment (TME) at cellular resolution.

Using the public GEO dataset [GSE197177](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE197177), this samples belong to either of the three cell types:

* Normal pancreatic tissue (NT)
* Primary pancreatic tumors (PT)
* Hepatic metastases (HM)

---

## Environment Setup

To create the analysis environment:

```bash
conda env create -f scrna_env.yml
conda activate myenv
```

---

## Analysis Workflow

### 1. Quality Control (QC)

* Removed cells with fewer than 100 detected genes
* Removed genes expressed in fewer than 3 cells
* Calculated mitochondrial gene percentage
* Detected and filtered doublets using **Scrublet**
* Generated violin plots for QC metrics

### 2. Normalization and Feature Selection

* Normalized counts to 10,000 reads per cell
* Log-transformed data
* Selected 10,000 highly variable genes using the Seurat v3 method

### 3. Dimensionality Reduction and Clustering

* Performed PCA followed by UMAP/t-SNE
* Applied the **Leiden** clustering algorithm (resolution = 0.5–0.6)
* Identified 29 clusters across samples

### 4. Batch Correction

* Integrated samples using **Harmony** to correct for batch effects

### 5. Marker Gene Identification

* Used logistic regression (`sc.tl.rank_genes_groups`) for differential expression
* Filtered markers by adjusted p-value < 0.05 and log fold-change > 0.5

### 6. Automated Cell Type Annotation

* Annotated immune cell types using **CellTypist** with the `Immune_All_Low.pkl` model

### 7. Manual Cell Type Annotation

Combined literature-based markers and Zhang et al., 2023 reference.

| Cluster IDs       | Cell Type               |
| ----------------- | ----------------------- |
| 0, 4, 16, 22      | Ductal cells            |
| 1, 6, 9, 26       | T cells                 |
| 2, 10, 12, 14, 24 | Macrophages / Monocytes |
| 3, 7              | Acinar cells            |
| 5                 | Fibroblasts             |
| 8                 | NK cells                |
| 11, 20, 21        | Plasma cells            |
| 18, 27, 28        | Endothelial cells       |

### 8. Trajectory Inference

* Used **PAGA** and **DPT** for pseudotime analysis of ductal cell differentiation
* Identified progression from NT to PT to HM states

### 9. Cell–Cell Communication Analysis

* Ran **CellPhoneDB** for NT, PT, and HM separately
* Analyzed ligand–receptor interactions to identify intercellular signaling patterns

---

## Observations

| Condition  | Summary                            |
| ---------- | ---------------------------------- |
| NT samples | Limited immune signaling           |
| PT samples | Active tumor–immune interactions   |
| HM samples | Dominant immunosuppressive signals |

---

## Tools and Libraries

| Tool                | Purpose                     |
| ------------------- | --------------------------- |
| Scanpy              | Core single-cell analysis   |
| Scrublet            | Doublet detection           |
| Harmony             | Batch correction            |
| CellTypist          | Automated cell annotation   |
| scCODA              | Compositional data analysis |
| CellPhoneDB         | Ligand–receptor analysis    |
| scVelo / PAGA / DPT | Trajectory inference        |
| Seaborn, Matplotlib | Visualization               |

---

## References

1. Zhang, S., Fang, W., Zhou, S. *et al.* (2023).
   *Single cell transcriptomic analyses implicate an immunosuppressive tumor microenvironment in pancreatic cancer liver metastasis.*
   *Nature Communications, 14, 5123.*
   [https://doi.org/10.1038/s41467-023-40727-7](https://doi.org/10.1038/s41467-023-40727-7)

2. Domínguez Conde, C., *et al.* (2022).
   *Cross-tissue immune cell analysis reveals tissue-specific features in humans.*
   *Science, 376(6594), eabl5197.*
   [https://doi.org/10.1126/science.abl5197](https://doi.org/10.1126/science.abl5197)
