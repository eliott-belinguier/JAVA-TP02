package fr.belinguier.vue;

import java.io.*;
import java.sql.*;
import java.util.function.Consumer;

public class VueDataBase {

    private final File sqlFile;
    private Connection connection;

    public VueDataBase(final File sqlFile) throws ClassNotFoundException, SQLException {
        if (sqlFile == null)
            throw new NullPointerException("sqlfile parameter must be not null.");
        this.sqlFile = sqlFile;
        Class.forName("org.sqlite.JDBC");
        openConnection();
        this.connection.setAutoCommit(false);
    }

    public Connection openConnection() throws SQLException {
        try {
            if (this.connection != null && !this.connection.isClosed())
                return this.connection;
        } catch (SQLException ignored) {}
        return (this.connection = DriverManager.getConnection("jdbc:sqlite:" + sqlFile.getPath()));
    }

    public void closeConnection() throws SQLException {
        if (this.connection != null && !this.connection.isClosed())
            this.connection.close();
    }

    public Connection getConnection() {
        try {
            if (this.connection != null && !this.connection.isClosed())
                return this.connection;
        } catch (final SQLException ignored) {}
        this.connection = null;
        return null;
    }

    public void executeStatement(final SQLConsumer<Statement> statementConsumer) throws SQLException {
        final Connection connection;
        final Statement statement;

        if (statementConsumer == null)
            throw new NullPointerException("statementConsumer parameter must be not null.");
        connection = getConnection();
        statement = connection.createStatement();
        statementConsumer.accept(statement);
        statement.close();
        connection.commit();
    }

    public void executeStatementQuery(final String sqlStr, final SQLConsumer<ResultSet> resultConsumer) throws SQLException {
        final Connection connection;
        final Statement statement;
        final ResultSet resultSet;

        if (sqlStr == null)
            throw new NullPointerException("statementConsumer parameter must be not null.");
        if (resultConsumer == null)
            throw new NullPointerException("resultConsumer parameter must be not null.");
        connection = getConnection();
        statement = connection.createStatement();
        resultSet = statement.executeQuery(sqlStr);
        resultConsumer.accept(resultSet);
        resultSet.close();
        statement.close();
        connection.commit();
    }

    public void executePreparedStatementQuery(final String sqlStr, final SQLConsumer<PreparedStatement> statementConsumer,
                                              final SQLConsumer<ResultSet> resultConsumer) throws SQLException {
        final Connection connection;
        final PreparedStatement preparedStatement;
        final ResultSet resultSet;

        if (sqlStr == null)
            throw new NullPointerException("sqlStr parameter must be not null.");
        if (statementConsumer == null)
            throw new NullPointerException("statementConsumer parameter must be not null.");
        if (resultConsumer == null)
            throw new NullPointerException("resultConsumer parameter must be not null.");
        connection = getConnection();
        if (connection == null)
            return;
        preparedStatement = connection.prepareStatement(sqlStr);
        statementConsumer.accept(preparedStatement);
        resultSet = preparedStatement.executeQuery();
        connection.commit();
        resultConsumer.accept(resultSet);
        resultSet.close();
        preparedStatement.close();
    }

    public void executeNativeSQL(final String sqlStr) throws SQLException {
        final Connection connection;
        final Statement statement;

        if (sqlStr == null)
            throw new NullPointerException("sqlStr parameter must be not null.");
        connection = getConnection();
        if (connection == null)
            return;
        connection.createStatement();
        statement = connection.createStatement();
        statement.executeUpdate(sqlStr);
        statement.close();
        connection.commit();
    }

    public void setupDataBase(final InputStream inputStream) throws IOException, SQLException {
        final BufferedReader reader;
        final StringBuilder stringBuilder;
        String line;


        if (inputStream == null)
            throw new NullPointerException("inputStream parameter must be not null.");
        reader = new BufferedReader(new InputStreamReader(inputStream));
        stringBuilder = new StringBuilder();
        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
            stringBuilder.append('\n');
        }
        executeNativeSQL(stringBuilder.toString());
    }

    public void setupDataBaseFromResource(final Class<?> clazz, final String resourceName) throws IOException, SQLException {
        final InputStream inputStream;

        if (clazz == null)
            throw new NullPointerException("clazz parameter must be not null.");
        if (resourceName == null)
            throw new NullPointerException("resourceName parameter must be not null.");
        inputStream = clazz.getResourceAsStream(resourceName);
        if (inputStream == null)
            throw new IOException(resourceName + " internal resource not found.");
        try {
            setupDataBase(inputStream);
        } catch (final Exception exception) {
            inputStream.close();
            throw exception;
        }
    }

}
