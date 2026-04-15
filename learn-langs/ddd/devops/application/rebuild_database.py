"""Script para reconstruir la base de datos desde cero."""

import asyncio
from pathlib import Path
import aiosqlite


async def rebuild_database():
    """Elimina y reconstruye la base de datos."""
    # Ruta de la base de datos
    db_path = Path(__file__).parent / "data" / "learn_lang.db"
    
    # Eliminar base de datos existente si existe
    if db_path.exists():
        print(f"🗑️  Eliminando base de datos existente: {db_path}")
        db_path.unlink()
    
    # Crear directorio de datos si no existe
    db_path.parent.mkdir(parents=True, exist_ok=True)
    
    # Ruta de migraciones
    migrations_path = Path(__file__).parent / "ddd" / "vocabulary" / "infrastructure" / "persistence" / "migrations"
    
    # Conectar y ejecutar migraciones
    print(f"📦 Creando nueva base de datos...")
    conn = await aiosqlite.connect(str(db_path))
    conn.row_factory = aiosqlite.Row
    
    try:
        await conn.execute("PRAGMA foreign_keys = ON")
        
        # Ejecutar todas las migraciones en orden
        migration_files = sorted(migrations_path.glob("*.sql"))
        
        for migration_file in migration_files:
            print(f"▶️  Ejecutando migración: {migration_file.name}")
            sql = migration_file.read_text(encoding="utf-8")
            await conn.executescript(sql)
        
        await conn.commit()
        print("✅ Base de datos reconstruida exitosamente!")
        
    except Exception as e:
        print(f"❌ Error al reconstruir base de datos: {e}")
        raise
    finally:
        await conn.close()


if __name__ == "__main__":
    asyncio.run(rebuild_database())
