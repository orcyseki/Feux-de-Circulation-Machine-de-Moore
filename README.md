# Feux-de-Circulation-Machine-de-Moore

## 📄 Description
Ce projet implémente un contrôleur de feux de circulation basé sur une **machine à états finis de type Moore**.  
Le système gère les cycles de feux tricolores (rouge → vert → orange → rouge) pour un carrefour simple.  

Il s'agit d'un projet pédagogique permettant de comprendre le fonctionnement des **machines séquentielles** et leur application à des systèmes embarqués.

---

## ➕ Objectifs
- Illustrer le fonctionnement d’une machine de Moore appliquée à un feu de circulation.
- Fournir un exemple pratique de conception en **VHDL**.
- Servir de base pour des extensions vers des feux interactifs (capteurs piétons, véhicules, etc.).

---


## 🔄 Fonctionnement
- Chaque état de la machine correspond à une couleur spécifique du feu.  
- Les transitions se font de manière séquentielle : rouge → vert → orange → rouge.  
- La durée de chaque feu est paramétrable dans le code VHDL.  

---

## 🖥️ Simulation
Pour simuler le projet :
1. Ouvrir le projet avec Vivado.
2. Compiler les fichiers VHDL.
3. Lancer le banc d’essai `tb_feu_de_circulation.vhd`.
4. Observer les transitions des feux.

---

## ✅ Statut
- Projet **fonctionnel** en simulation.
- Peut être synthétisé pour une **implémentation sur FPGA**.

---

## 🔧 Améliorations possibles
- Ajouter des capteurs pour un fonctionnement interactif → transition vers une machine de Moore  + logique combinatoire.
- Gérer plusieurs voies et directions sur un carrefour.
- Adapter la durée des feux selon la densité de trafic.

---

## 📚 Technologies utilisées
- **Langage** : VHDL
- **Simulation / synthèse** : Vivado
