#!/bin/bash

# Definir colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

# Logo
echo -e "${BLUE}_____   _             ___     __    __   ___               ___   _         _ 
 |_   _| | |_    ___   / _ \   / _|  / _| / __|  ___   __   / __| (_)  _ _  | |
   | |   | ' \  / -_) | (_) | |  _| |  _| \__ \ / -_) / _| | (_ | | | | '_| | |
   |_|   |_||_| \___|  \___/  |_|   |_|   |___/ \___| \__|  \___| |_| |_|   |_|${NC}"

# Función para validar el nombre del programa
validate_program_name() {
    if [[ -z "$1" || ! "$1" =~ ^[a-zA-Z0-9_]+$ ]]; then
        echo -e "${RED}Error: El nombre del programa no debe estar vacío y solo puede contener letras, números y guiones bajos.${NC}"
        exit 1
    fi
}

# Función para crear estructura de carpetas y añadir detalles para BBP
create_bbp_structure() {
    mkdir -p "$program/findings"
    mkdir -p "$program/reporting"

    {
        echo "# Proyecto $program (BBP)"
        echo "Este es un proyecto de Bug Bounty Program."
        echo "Asegúrate de seguir las reglas y políticas del programa."
        echo -e "\n## Detalles de los Targets\n"
        echo "$targets_details"
        echo -e "\n### Reglas del Programa:\n"
        echo "$rules"
        echo -e "\n### Alcance del Programa\n"
        echo "#### In Scope:"
        echo "$in_scope"
        echo -e "\n#### Out of Scope:"
        echo "$out_of_scope"
    } > "$program/README.md"

    # Crear plantilla de reporte
    {
        echo "# Plantilla de Reporte"
        echo "## Información del Reporte"
        echo "- **Título:** [Título de la vulnerabilidad]"
        echo "- **Descripción:** [Descripción detallada de la vulnerabilidad]"
        echo "- **Pasos para Reproducir:**"
        echo "  1. [Paso 1]"
        echo "  2. [Paso 2]"
        echo "  3. [Paso 3]"
        echo "- **Impacto:** [Descripción del impacto de la vulnerabilidad]"
        echo "- **Solución Recomendada:** [Solución recomendada para mitigar la vulnerabilidad]"
        echo "- **Archivos Adjuntos:** [Incluir capturas de pantalla, logs o cualquier otro archivo relevante]"
    } > "$program/reporting/report_template.md"
}

# Función para crear estructura de carpetas y añadir detalles para VDP
create_vdp_structure() {
    mkdir -p "$program/findings"
    mkdir -p "$program/disclosure"

    {
        echo "# Proyecto $program (VDP)"
        echo "Este es un proyecto de Vulnerability Disclosure Program."
        echo "Por favor, sigue las directrices para la divulgación responsable."
        echo -e "\n## Detalles de los Targets\n"
        echo "$targets_details"
        echo -e "\n### Reglas del Programa:\n"
        echo "$rules"
        echo -e "\n### Alcance del Programa\n"
        echo "#### In Scope:"
        echo "$in_scope"
        echo -e "\n#### Out of Scope:"
        echo "$out_of_scope"
    } > "$program/README.md"

    # Crear plantilla de reporte
    {
        echo "# Plantilla de Reporte"
        echo "## Información del Reporte"
        echo "- **Título:** [Título de la vulnerabilidad]"
        echo "- **Descripción:** [Descripción detallada de la vulnerabilidad]"
        echo "- **Pasos para Reproducir:**"
        echo "  1. [Paso 1]"
        echo "  2. [Paso 2]"
        echo "  3. [Paso 3]"
        echo "- **Impacto:** [Descripción del impacto de la vulnerabilidad]"
        echo "- **Solución Recomendada:** [Solución recomendada para mitigar la vulnerabilidad]"
        echo "- **Archivos Adjuntos:** [Incluir capturas de pantalla, logs o cualquier otro archivo relevante]"
    } > "$program/disclosure/report_template.md"
}

# Mostrar el mensaje al usuario
echo "Introduce el nombre del programa: "
read program

# Validar el nombre del programa
validate_program_name "$program"

# Preguntar si es BBP o VDP
echo "¿Es este un Bug Bounty Program (BBP) o un Vulnerability Disclosure Program (VDP)? (escribe BBP o VDP)"
read program_type

# Preguntar detalles sobre los targets
echo "Introduce los detalles sobre los targets  (separa cada target con una coma):"
read targets_details

# Solicitar las reglas del programa
echo "Por favor, especifica las reglas que deben seguirse en este programa:"
read rules

# Preguntar sobre el alcance del programa
echo "Introduce los elementos que están **dentro del alcance** (In Scope):"
read in_scope

echo "Introduce los elementos que están **fuera del alcance** (Out of Scope):"
read out_of_scope

# Crear la estructura de carpetas en función del tipo de programa
case "$program_type" in
    BBP|bbp)
        create_bbp_structure
        program="${program}_BBP"
        ;;
    VDP|vdp)
        create_vdp_structure
        program="${program}_VDP"
        ;;
    *)
        echo -e "${RED}Error: Tipo de programa no reconocido. Por favor, escribe 'BBP' o 'VDP'.${NC}"
        exit 1
        ;;
esac

# Mensajes de éxito
echo -e "${GREEN}Se ha creado la estructura de carpetas para el programa '$program'.${NC}"
