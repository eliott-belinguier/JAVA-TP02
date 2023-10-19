package fr.belinguier.vue;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class Main {

    private static VueDataBase createDataBase(final String fileName) throws IOException, SQLException, ClassNotFoundException {
        final File sqlFile = new File(fileName);

        if (sqlFile.exists())
            sqlFile.delete();
        sqlFile.createNewFile();
        return new VueDataBase(sqlFile);
    }

    /**
     * Vous trouverez ici la création des différentes vues.
     */
    private static void setupDataBase(final VueDataBase vueDataBase) throws SQLException {
        vueDataBase.executeStatement(stmt -> {
            // Vue 1
            stmt.executeUpdate("CREATE VIEW nbOccurenceMotsManche AS SELECT idPartie, numMot, mot, COUNT(*) as nbOccurence FROM listes GROUP BY idPartie, numMot, mot");
            // Vue 2
            stmt.executeUpdate("CREATE VIEW nbOccurenceMotsCartes AS SELECT idCarte, concept, mot, COUNT(*) as nbOccurence FROM listes JOIN cartes ON listes.idCarte = cartes.idCarte GROUP BY listes.idCarte, mot");
            // Vue 3
            stmt.executeUpdate("CREATE VIEW scoreJoueurs AS SELECT idPartie, idJoueur, SUM(nbOccurence-1) as score FROM nbOccurenceMotsManche GROUP BY idPartie, idJoueur");
            // Vue 4
            stmt.executeUpdate("CREATE VIEW nbOccurenceParPosition AS SELECT idCarte, mot, numMot, COUNT(*) as nbOccurence FROM listes GROUP BY idCarte, mot, numMot");
        });
    }

    private static void displayResult(final ResultSet resultSet) throws SQLException {
        final ResultSetMetaData metaData = resultSet.getMetaData();
        int result_row = 0;

        System.out.print("Result: ");
        while (resultSet.next()) {
            System.out.printf("\n\tRow %d:", result_row++);
            for (int i = 1; i < metaData.getColumnCount(); i++)
                System.out.println("\n\t\t" + metaData.getColumnName(i) + ": " + resultSet.getObject(1));
        }
        System.out.println();
    }

    public static void main(String[] args) {
        final VueDataBase vueDataBase;

        try {
            vueDataBase = createDataBase("database.db");
            vueDataBase.setupDataBaseFromResource(Main.class, "/Unanimo_creation.sql");
            setupDataBase(vueDataBase);
        } catch (final Exception exception) {
            exception.printStackTrace();
            return;
        }


        try {
            vueDataBase.executeStatementQuery("SELECT mot FROM nbOccurenceParPosition WHERE numMot <= 4 GROUP BY mot HAVING COUNT(DISTINCT numMot) = 4", Main::displayResult);
            vueDataBase.executeStatementQuery("SELECT mot FROM nbOccurenceParPosition WHERE numMot >= 5 GROUP BY mot HAVING COUNT(DISTINCT numMot) = 4", Main::displayResult);
            vueDataBase.executeStatementQuery("SELECT mot FROM nbOccurenceParPosition GROUP BY mot HAVING COUNT(DISTINCT numMot) = 8", Main::displayResult);
            vueDataBase.executeStatementQuery("SELECT l1.mot as mot1, l2.mot as mot2, COUNT(*) as coOccurence FROM listes l1 JOIN listes l2 ON l1.idPartie = l2.idPartie AND l1.idJoueur = l2.idJoueur AND l1.idCarte = l2.idCarte WHERE l1.mot <> l2.mot GROUP BY l1.mot, l2.mot HAVING coOccurence > 1", Main::displayResult);
            vueDataBase.executeStatementQuery("SELECT l1.mot as mot1, l2.mot as mot2, ABS(l1.numMot - l2.numMot) as distance FROM listes l1 JOIN listes l2 ON l1.idPartie = l2.idPartie AND l1.idJoueur = l2.idJoueur AND l1.idCarte = l2.idCarte WHERE l1.mot <> l2.mot", Main::displayResult);
            vueDataBase.executeStatementQuery("SELECT mot1, mot2, AVG(distance) as moyenne_distance, MAX(distance) as max_distance, MIN(distance) as min_distance, COUNT(*) as cooccurences FROM ( SELECT l1.mot as mot1, l2.mot as mot2, ABS(l1.numMot - l2.numMot) as distance FROM listes l1 JOIN listes l2 ON l1.idPartie = l2.idPartie AND l1.idJoueur = l2.idJoueur AND l1.idCarte = l2.idCarte WHERE l1.mot <> l2.mot ) sub GROUP BY mot1, mot2", Main::displayResult);
        } catch (SQLException exception) {
            exception.printStackTrace();
        }

        try {
            vueDataBase.closeConnection();
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }

}
